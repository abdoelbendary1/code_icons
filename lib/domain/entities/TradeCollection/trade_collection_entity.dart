class TradeCollectionEntity {
  int? idBl;
  String? collectionDateBl;
  String? yearsOfRepaymentBl;
  dynamic yearsOfRepaymentLstBl;
  String? paymentReceiptNumBl;
  double? compensationBl;
  double? activityBL;
  double? lateBl;
  double? currentBl;
  double? differentBl;
  double? totalBl;
  dynamic notesBl;
  int? customerDataIdBl;
  /* String? cutomerName;
  String? address; */

  TradeCollectionEntity({
    this.idBl,
    this.collectionDateBl,
    this.yearsOfRepaymentBl,
    this.yearsOfRepaymentLstBl,
    this.paymentReceiptNumBl,
    this.compensationBl,
    this.lateBl,
    this.currentBl,
    this.differentBl,
    this.totalBl,
    this.notesBl,
    this.customerDataIdBl,this.activityBL,
    String? cutomerName,
    String? address,
    /*  this.cutomerName,
    this.address, */
  });
}
