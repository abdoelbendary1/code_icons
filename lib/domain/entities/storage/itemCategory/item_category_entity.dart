class ItemCategoryEntity {
  int? catId;
  String? catCode;
  String? catNameAr;
  dynamic calcMethodIdBl;
  dynamic calcMethod;
  dynamic userId;
  dynamic lastUpdateUserId;
  String? insertDate;
  dynamic lastUpdateDate;
  dynamic parentId;
  dynamic items;
  dynamic imagePath;
  dynamic images;

  ItemCategoryEntity(
      {this.catId,
      this.catCode,
      this.catNameAr,
      this.calcMethodIdBl,
      this.calcMethod,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate,
      this.parentId,
      this.items,
      this.imagePath,
      this.images});
}
