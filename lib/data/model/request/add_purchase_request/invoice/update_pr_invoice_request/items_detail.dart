class ItemsDetail {
  String? id;
  int? invoiceId;
  int? itemNameAr;
  int? currentQty;
  dynamic description;
  int? qty;
  int? precentage;
  int? precentagevalue;
  int? uom;
  int? prprice;
  int? alltaxesvalue;
  int? totalprice;
  dynamic idStore;
  int? length;
  int? width;
  int? height;
  dynamic expiryDate;
  dynamic batch;
  int? allQtyValue;
  dynamic mClassificationIdBl;
  String? foreignKey;
  int? itemCode1;

  ItemsDetail({
    this.id,
    this.invoiceId,
    this.itemNameAr,
    this.currentQty,
    this.description,
    this.qty,
    this.precentage,
    this.precentagevalue,
    this.uom,
    this.prprice,
    this.alltaxesvalue,
    this.totalprice,
    this.idStore,
    this.length,
    this.width,
    this.height,
    this.expiryDate,
    this.batch,
    this.allQtyValue,
    this.mClassificationIdBl,
    this.foreignKey,
    this.itemCode1,
  });

  factory ItemsDetail.fromJson(Map<String, dynamic> json) => ItemsDetail(
        id: json['id'] as String?,
        invoiceId: json['invoiceId'] as int?,
        itemNameAr: json['itemNameAr'] as int?,
        currentQty: json['currentQty'] as int?,
        description: json['description'] as dynamic,
        qty: json['qty'] as int?,
        precentage: json['precentage'] as int?,
        precentagevalue: json['precentagevalue'] as int?,
        uom: json['uom'] as int?,
        prprice: json['prprice'] as int?,
        alltaxesvalue: json['alltaxesvalue'] as int?,
        totalprice: json['totalprice'] as int?,
        idStore: json['idStore'] as dynamic,
        length: json['length'] as int?,
        width: json['width'] as int?,
        height: json['height'] as int?,
        expiryDate: json['expiryDate'] as dynamic,
        batch: json['batch'] as dynamic,
        allQtyValue: json['allQtyValue'] as int?,
        mClassificationIdBl: json['mClassificationIdBL'] as dynamic,
        foreignKey: json['foreignKey'] as String?,
        itemCode1: json['itemCode1'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoiceId': invoiceId,
        'itemNameAr': itemNameAr,
        'currentQty': currentQty,
        'description': description,
        'qty': qty,
        'precentage': precentage,
        'precentagevalue': precentagevalue,
        'uom': uom,
        'prprice': prprice,
        'alltaxesvalue': alltaxesvalue,
        'totalprice': totalprice,
        'idStore': idStore,
        'length': length,
        'width': width,
        'height': height,
        'expiryDate': expiryDate,
        'batch': batch,
        'allQtyValue': allQtyValue,
        'mClassificationIdBL': mClassificationIdBl,
        'foreignKey': foreignKey,
        'itemCode1': itemCode1,
      };
}
