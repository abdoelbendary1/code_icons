class ItemCompanyEntity {
  int? comId;
  String? comCode;
  String? comNameAr;
  int? userId;
  dynamic lastUpdateUserId;
  String? insertDate;
  dynamic lastUpdateDate;
  dynamic parentId;
  dynamic items;

  ItemCompanyEntity(
      {this.comId,
      this.comCode,
      this.comNameAr,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate,
      this.parentId,
      this.items});
}
