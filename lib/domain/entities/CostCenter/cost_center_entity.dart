class CostCenterEntity {
  int? id;
  String? costcenterNameAr;
  dynamic costcenterNameEn;
  int? level;
  dynamic parentId;
  String? code;
  dynamic costCenter;
  int? userId;
  dynamic lastUpdateUserId;
  String? insertDate;
  dynamic lastUpdateDate;
  dynamic items;

  CostCenterEntity(
      {this.id,
      this.costcenterNameAr,
      this.costcenterNameEn,
      this.level,
      this.parentId,
      this.code,
      this.costCenter,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate,
      this.items});
}
