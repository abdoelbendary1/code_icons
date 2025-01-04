class StoreEntity {
  int? storeId;
  String? storeCode;
  String? storeNameAr;
  dynamic storeNameEn;
  String? managerName;
  String? address;
  dynamic tel;
  dynamic mobile;
  bool? isStopped;
  dynamic parentId;
  dynamic parent;
  dynamic parentName;
  int? stockMethod;
  int? sellAccount;
  int? sellReturnAccount;
  int? inventoryAccount;
  int? costOfSoldGoodsAcc;
  int? salesDiscountAcc;
  int? purchaseDiscountAcc;
  dynamic costCenter;
  int? userId;
  int? lastUpdateUserId;
  String? insertDate;
  String? lastUpdateDate;

  StoreEntity(
      {this.storeId,
      this.storeCode,
      this.storeNameAr,
      this.storeNameEn,
      this.managerName,
      this.address,
      this.tel,
      this.mobile,
      this.isStopped,
      this.parentId,
      this.parent,
      this.parentName,
      this.stockMethod,
      this.sellAccount,
      this.sellReturnAccount,
      this.inventoryAccount,
      this.costOfSoldGoodsAcc,
      this.salesDiscountAcc,
      this.purchaseDiscountAcc,
      this.costCenter,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate});
}
