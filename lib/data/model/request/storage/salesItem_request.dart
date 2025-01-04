class ItemRequest {
  double? smallUomPrice;
  double? smallUoMprPrice;
  int? itemType;
  String? itemNameAr;
  int? category;
  int? company;
  int? smallUom;

  ItemRequest(
      {this.smallUomPrice,
      this.smallUoMprPrice,
      this.itemType,
      this.itemNameAr,
      this.category,
      this.company,
      this.smallUom});

  ItemRequest.fromJson(Map<String, dynamic> json) {
    smallUomPrice = json["smallUOMPrice"];
    smallUoMprPrice = json["smallUOMprPrice"];
    itemType = json["itemType"];
    itemNameAr = json["itemNameAr"];
    category = json["category"];
    company = json["company"];
    smallUom = json["smallUOM"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["smallUOMPrice"] = smallUomPrice;
    _data["smallUOMprPrice"] = smallUoMprPrice;
    _data["itemType"] = itemType;
    _data["itemNameAr"] = itemNameAr;
    _data["category"] = category;
    _data["company"] = company;
    _data["smallUOM"] = smallUom;
    return _data;
  }
}
