import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/services/controllers.dart';

import 'package:hive_flutter/hive_flutter.dart';

class ReceiptManager {
  late int paymentReceipt;
  int? storedPaymentReceipt;
  List<RecietCollectionDataModel> receipts = [];
  RecietCollectionDataModel selectedReceipt = RecietCollectionDataModel();

  Future<List<RecietCollectionDataModel>> getReceipts() async {
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');
    String token = userBox.get('accessToken') ?? '';
    List<dynamic> existingReceipts = receiptsBox.get(token, defaultValue: []);
    receipts = existingReceipts
        .map((i) => RecietCollectionDataModel.fromJson(i))
        .toList();
    return receipts;
  }

  Future<int?> getPaymentReceipt() async {
    var userBox = Hive.box('userBox');
    return userBox.get('paymentReceipt');
  }

  Future<void> addReceipt(RecietCollectionDataModel newReceipt) async {
    try {
      var userBox = Hive.box('userBox');
      var receiptsBox = Hive.box('receiptsBox');
      String token = userBox.get('accessToken') ?? '';
      List<dynamic> existingReceipts = receiptsBox.get(token, defaultValue: []);

      existingReceipts.add(newReceipt.toJson());
      receiptsBox.put(token, existingReceipts);

      var storedPaymentReciept = await getPaymentReceipt();
      if (storedPaymentReciept == null) {
        await storePaymentReceipt(
            receipts.firstWhere((element) => element.valid == true).paperNum!);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<RecietCollectionDataModel> selectReceipt(int paymentReceipt) async {
    try {
      for (var receipt in receipts) {
        receipt.valid =
            (receipt.paperNum! + receipt.totalPapers!) > paymentReceipt;
      }

      selectedReceipt = receipts.firstWhere((receipt) => receipt.valid!);
      return selectedReceipt;
    } catch (e) {
      await addReceipt(RecietCollectionDataModel(
          id: receipts.length + 1, paperNum: 1, totalPapers: 20, valid: true));
      return receipts.last;
    }
  }

  Future<void> storePaymentReceipt(int receipt) async {
    var userBox = Hive.box('userBox');
    userBox.put('paymentReceipt', receipt);
  }

  Future<void> initialize({required String controller}) async {
    await getReceipts();
    storedPaymentReceipt = await getPaymentReceipt();

    if (storedPaymentReceipt == null) {
      await storePaymentReceipt(1);
      storedPaymentReceipt = 1;
    }
    paymentReceipt = storedPaymentReceipt!;

    if (receipts.isNotEmpty) {
      selectedReceipt = await selectReceipt(paymentReceipt);
      if (!selectedReceipt.valid!) {
        selectedReceipt = await selectReceipt(paymentReceipt);
        paymentReceipt = selectedReceipt.paperNum!;
        await storePaymentReceipt(paymentReceipt);
      }
    } else {
      await addReceipt(RecietCollectionDataModel(
          id: receipts.length + 1, paperNum: 1, totalPapers: 20, valid: true));
      receipts = await getReceipts();
      selectedReceipt = receipts.firstWhere((element) => element.valid!);
      paymentReceipt = selectedReceipt.paperNum!;
      await storePaymentReceipt(paymentReceipt);
    }
    updateController(controller: controller);
  }

  void updateController({required String controller}) {
    ControllerManager().getControllerByName(controller).text =
        paymentReceipt.toString();
  }

  Future<void> incrementPaymentReceipt() async {
    int? storedPaymentReceipt = await getPaymentReceipt();
    if (storedPaymentReceipt != null) {
      paymentReceipt = storedPaymentReceipt + 1;
      await storePaymentReceipt(paymentReceipt);
      ControllerManager()
          .getControllerByName('unlimitedPaymentReceiptController')
          .text = paymentReceipt.toString();
    } else {
      paymentReceipt = selectedReceipt.paperNum!;
      await storePaymentReceipt(paymentReceipt);
      ControllerManager()
          .getControllerByName('unlimitedPaymentReceiptController')
          .text = paymentReceipt.toString();
    }
  }
}
