import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReceiptManager {
  Future<int?> getPaymentReceipt({required int userId}) async {
    var userBox = Hive.box('userBox');

    // Get the user's data
    Map<dynamic, dynamic>? userData =
        userBox.get(userId.toString()) as Map<dynamic, dynamic>?;

    // Return the paymentReceipt if it exists
    return userData?['paymentReceipt'];
  }

  Future<void> storePaymentNumber({
    required int userId,
    required int receipt,
  }) async {
    var userBox = Hive.box('userBox');

    // Get existing user data or create a new map
    Map<dynamic, dynamic> userData = userBox
        .get(userId.toString(), defaultValue: {}) as Map<dynamic, dynamic>;

    // Update the paymentReceipt
    userData['paymentReceipt'] = receipt;

    // Save the updated user data
    userBox.put(userId.toString(), userData);
  }

  Future<void> addReciet({
    List<RecietCollectionDataModel>? receipts,
    int? storedPaymentReceipt,
  }) async {
    try {
      var userBox = Hive.box('userBox');
      var receiptsBox = Hive.box('receiptsBox');

      // Retrieve user token

      AuthRepoEntity? user = userBox.get('user');
      int userID = user!.id!;

      List<dynamic> existingReceipts =
          receiptsBox.get(userID, defaultValue: []);
      RecietCollectionDataModel newReciept;
      // Create new receipt
      if (receipts != null && receipts.isNotEmpty) {
        newReciept = RecietCollectionDataModel(
            valid: true,
            id: receipts.last.id! + 1,
            paperNum: storedPaymentReceipt,
            totalPapers: 50);
      } else {
        newReciept = RecietCollectionDataModel(
            valid: true, id: 1, paperNum: 1, totalPapers: 50);
      }

      // Add new receipt to the list
      existingReceipts.add(newReciept.toJson());

      // Save the updated receipts list
      receiptsBox.put(userID, existingReceipts);
      var storedPaymentReciet = await getPaymentReceipt(userId: userID);
      if (storedPaymentReciet == null) {
        await storePaymentNumber(
            receipt: receipts
                    ?.firstWhere((element) => element.valid == true)
                    .paperNum ??
                0,
            userId: userID);
      }
    } catch (e) {}
  }
}
