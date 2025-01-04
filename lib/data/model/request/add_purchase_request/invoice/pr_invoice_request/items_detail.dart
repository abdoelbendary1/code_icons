class ItemsDetail {
  int? itemCode1;
  int? itemNameAr;
  dynamic description;
  double? length;
  double? width;
  double? height;
  int? qty;
  double? precentage;
  double? precentagevalue;
  int? uom;
  double? currentQty;
  double? prprice;
  String? allQtyValue;
  String? totalprice;
  String? id;
  String? foreignKey;

  ItemsDetail({
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
    this.currentQty,
    this.prprice,
    this.allQtyValue,
    this.totalprice,
    this.id,
    this.foreignKey,
  });

  factory ItemsDetail.fromJson(Map<String, dynamic> json) => ItemsDetail(
        itemCode1: json['itemCode1'] as int?,
        itemNameAr: json['itemNameAr'] as int?,
        description: json['description'] as dynamic,
        length: json['length'] as double?,
        width: json['width'] as double?,
        height: json['height'] as double?,
        qty: json['qty'] as int?,
        precentage: json['precentage'] as double?,
        precentagevalue: json['precentagevalue'] as double?,
        uom: json['uom'] as int?,
        currentQty: json['currentQty'] as double?,
        prprice: json['prprice'] as double?,
        allQtyValue: json['allQtyValue'] as String?,
        totalprice: json['totalprice'] as String?,
        id: json['id'] as String?,
        foreignKey: json['foreignKey'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'itemCode1': itemCode1,
        'itemNameAr': itemNameAr,
        'description': description,
        'length': length,
        'width': width,
        'height': height,
        'qty': qty,
        'precentage': precentage,
        'precentagevalue': precentagevalue,
        'uom': uom,
        'currentQty': currentQty,
        'prprice': prprice,
        'allQtyValue': allQtyValue,
        'totalprice': totalprice,
        'id': id,
        'foreignKey': foreignKey,
      };
}
