class InvoiceItemDetailsDm {
  int? itemCode1;
  int? itemNameAr;
  String? description;
  double? length;
  double? width;
  double? height;
  double? qty;
  double? precentage;
  double? precentagevalue;
  int? uom;
  double? prprice;
  double? currentQty;
  dynamic? allQtyValue;
  double? alltaxesvalue;
  dynamic? totalprice;
  String? id;
  String? foreignKey;
  int? invoiceId;

  InvoiceItemDetailsDm({
    this.itemCode1,
    this.itemNameAr,
    this.description,
    this.length,
    this.width,
    this.height,
    this.qty,
    this.precentage,
    this.precentagevalue,
    this.uom,
    this.prprice,
    this.currentQty,
    this.allQtyValue,
    this.alltaxesvalue,
    this.totalprice,
    this.id,
    this.foreignKey,
    this.invoiceId,
  });

  // Method to convert JSON to model
  factory InvoiceItemDetailsDm.fromJson(Map<String, dynamic> json) {
    return InvoiceItemDetailsDm(
      itemCode1: json["itemCode1"],
      itemNameAr: json["itemNameAr"],
      description: json["description"],
      invoiceId: json["invoiceId"],
      length: (json["length"] ?? 0).toDouble(),
      width: (json["width"] ?? 0).toDouble(),
      height: (json["height"] ?? 0).toDouble(),
      qty: (json["qty"] ?? 0).toDouble(),
      precentage: (json["precentage"] ?? 0).toDouble(),
      precentagevalue: (json["precentagevalue"] ?? 0).toDouble(),
      uom: json["uom"],
      prprice: (json["prprice"] ?? 0).toDouble(),
      currentQty: (json["currentQty"] ?? 0).toDouble(),
      allQtyValue: (json["allQtyValue"] ?? 0).toDouble(),
      alltaxesvalue: (json["alltaxesvalue"] ?? 0).toDouble(),
      totalprice: json["totalprice"]?.toString(),
      id: json["id"]?.toString(),
      foreignKey: json["foreignKey"]?.toString(),
    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["itemCode1"] = itemCode1;
    if (invoiceId != null) {
      _data["invoiceId"] = invoiceId;
    }
    _data["itemNameAr"] = itemNameAr;
    _data["description"] = description;
    _data["length"] = length;
    _data["width"] = width;
    _data["height"] = height;
    _data["qty"] = qty;
    _data["precentage"] = precentage;
    _data["precentagevalue"] = precentagevalue;
    _data["uom"] = uom;
    _data["prprice"] = prprice;
    _data["currentQty"] = currentQty;
    _data["allQtyValue"] = allQtyValue;
    _data["alltaxesvalue"] = alltaxesvalue;
    _data["totalprice"] = totalprice;
    if (id != null) {
      _data["id"] = id;
    }
    if (foreignKey != null) {
      _data["foreignKey"] = foreignKey;
    }
    return _data;
  }
}
