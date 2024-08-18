import 'package:code_icons/domain/entities/store/store_entity.dart';

class StoreDataModel extends StoreEntity {
  StoreDataModel({
    super.storeId,
    super.storeCode,
    super.storeNameAr,
    super.storeNameEn,
    super.managerName,
    super.address,
    super.tel,
    super.mobile,
    super.isStopped,
    super.parentId,
    super.parent,
    super.parentName,
    super.stockMethod,
    super.sellAccount,
    super.sellReturnAccount,
    super.inventoryAccount,
    super.costOfSoldGoodsAcc,
    super.salesDiscountAcc,
    super.purchaseDiscountAcc,
    super.costCenter,
    super.userId,
    super.lastUpdateUserId,
    super.insertDate,
    super.lastUpdateDate,
  });

  StoreDataModel.fromJson(Map<String, dynamic> json) {
    if (json["storeId"] is int) {
      storeId = json["storeId"];
    }
    if (json["storeCode"] is String) {
      storeCode = json["storeCode"];
    }
    if (json["storeNameAr"] is String) {
      storeNameAr = json["storeNameAr"];
    }
    storeNameEn = json["storeNameEn"];
    if (json["managerName"] is String) {
      managerName = json["managerName"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    tel = json["tel"];
    mobile = json["mobile"];
    if (json["isStopped"] is bool) {
      isStopped = json["isStopped"];
    }
    parentId = json["parentId"];
    parent = json["parent"];
    parentName = json["parentName"];
    if (json["stockMethod"] is int) {
      stockMethod = json["stockMethod"];
    }
    if (json["sellAccount"] is int) {
      sellAccount = json["sellAccount"];
    }
    if (json["sellReturnAccount"] is int) {
      sellReturnAccount = json["sellReturnAccount"];
    }
    if (json["inventoryAccount"] is int) {
      inventoryAccount = json["inventoryAccount"];
    }
    if (json["costOfSoldGoodsAcc"] is int) {
      costOfSoldGoodsAcc = json["costOfSoldGoodsAcc"];
    }
    if (json["salesDiscountAcc"] is int) {
      salesDiscountAcc = json["salesDiscountAcc"];
    }
    if (json["purchaseDiscountAcc"] is int) {
      purchaseDiscountAcc = json["purchaseDiscountAcc"];
    }
    costCenter = json["costCenter"];
    if (json["userId"] is int) {
      userId = json["userId"];
    }
    if (json["lastUpdateUserId"] is int) {
      lastUpdateUserId = json["lastUpdateUserId"];
    }
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
    if (json["lastUpdateDate"] is String) {
      lastUpdateDate = json["lastUpdateDate"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["storeId"] = storeId;
    _data["storeCode"] = storeCode;
    _data["storeNameAr"] = storeNameAr;
    _data["storeNameEn"] = storeNameEn;
    _data["managerName"] = managerName;
    _data["address"] = address;
    _data["tel"] = tel;
    _data["mobile"] = mobile;
    _data["isStopped"] = isStopped;
    _data["parentId"] = parentId;
    _data["parent"] = parent;
    _data["parentName"] = parentName;
    _data["stockMethod"] = stockMethod;
    _data["sellAccount"] = sellAccount;
    _data["sellReturnAccount"] = sellReturnAccount;
    _data["inventoryAccount"] = inventoryAccount;
    _data["costOfSoldGoodsAcc"] = costOfSoldGoodsAcc;
    _data["salesDiscountAcc"] = salesDiscountAcc;
    _data["purchaseDiscountAcc"] = purchaseDiscountAcc;
    _data["costCenter"] = costCenter;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    return _data;
  }
}
