class InvoiceReportRequest {
  int? costcenter;
  int? crncId;
  int? customer;
  String? date;
  double? invDiscountP;
  double? invDiscountV;
  List<ItemDetail>? itemsDetails;
  double? paid;
  String? paymentMethod;
  double? rate;
  int? storeId;
  String? notes;
  List<dynamic>? outputTaxesDetails;

  InvoiceReportRequest({
    this.costcenter,
    this.crncId,
    this.customer,
    this.date,
    this.invDiscountP,
    this.invDiscountV,
    this.itemsDetails,
    this.paid,
    this.paymentMethod,
    this.rate,
    this.storeId,
    this.notes,
    this.outputTaxesDetails,
  });

  // Factory method to create the model from JSON
  factory InvoiceReportRequest.fromJson(Map<String, dynamic> json) {
    return InvoiceReportRequest(
      costcenter: json['costcenter'],
      crncId: json['crncId'],
      customer: json['customer'],
      date: json['date'],
      invDiscountP: json['invDiscountP'].toDouble(),
      invDiscountV: json['invDiscountV'].toDouble(),
      itemsDetails: json['itemsDetails'] != null
          ? (json['itemsDetails'] as List)
              .map((item) => ItemDetail.fromJson(item))
              .toList()
          : [],
      paid: json['paid'].toDouble(),
      paymentMethod: json['paymentMethod'],
      rate: json['rate'].toDouble(),
      storeId: json['storeId'],
      notes: json['notes'],
      outputTaxesDetails: json['outputTaxesDetails'] ?? [],
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['costcenter'] = costcenter;
    data['crncId'] = crncId;
    data['customer'] = customer;
    data['date'] = date;
    data['invDiscountP'] = invDiscountP;
    data['invDiscountV'] = invDiscountV;
    if (itemsDetails != null) {
      data['itemsDetails'] =
          itemsDetails!.map((item) => item.toJson()).toList();
    }
    data['paid'] = paid;
    data['paymentMethod'] = paymentMethod;
    data['rate'] = rate;
    data['storeId'] = storeId;
    data['notes'] = notes;
    data['outputTaxesDetails'] = outputTaxesDetails;
    return data;
  }
}

class ItemDetail {
  int? itemCode1;
  int? itemNameAr;
  String? description;
  double? length;
  double? width;
  double? height;
  int? qty;
  double? precentage;
  double? precentagevalue;
  int? uom;
  double? prprice;
  int? currentQTY;
  double? allQtyValue;
  double? alltaxesvalue;
  String? totalprice;
  String? id;
  String? foreignKey;

  ItemDetail({
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
    this.currentQTY,
    this.allQtyValue,
    this.alltaxesvalue,
    this.totalprice,
    this.id,
    this.foreignKey,
  });

  // Factory method to create the model from JSON
  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
      itemCode1: json['itemCode1'],
      itemNameAr: json['itemNameAr'],
      description: json['description'],
      length: json['length']?.toDouble(),
      width: json['width']?.toDouble(),
      height: json['height']?.toDouble(),
      qty: json['qty'],
      precentage: json['precentage']?.toDouble(),
      precentagevalue: json['precentagevalue']?.toDouble(),
      uom: json['uom'],
      prprice: json['prprice']?.toDouble(),
      currentQTY: json['currentQTY'],
      allQtyValue: json['allQtyValue']?.toDouble(),
      alltaxesvalue: json['alltaxesvalue']?.toDouble(),
      totalprice: json['totalprice'],
      id: json['id'],
      foreignKey: json['foreignKey'],
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemCode1'] = itemCode1;
    data['itemNameAr'] = itemNameAr;
    data['description'] = description;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['qty'] = qty;
    data['precentage'] = precentage;
    data['precentagevalue'] = precentagevalue;
    data['uom'] = uom;
    data['prprice'] = prprice;
    data['currentQTY'] = currentQTY;
    data['allQtyValue'] = allQtyValue;
    data['alltaxesvalue'] = alltaxesvalue;
    data['totalprice'] = totalprice;
    data['id'] = id;
    data['foreignKey'] = foreignKey;
    return data;
  }
}
