class CurrencyEntity {
  int? id;
  dynamic piaster3Ar;
  dynamic piaster2Ar;
  dynamic piaster3En;
  dynamic piaster2En;
  dynamic piaster1Ar;
  dynamic piaster1En;
  dynamic pound3Ar;
  dynamic pound3En;
  dynamic pound2En;
  dynamic pound2Ar;
  dynamic pound1En;
  dynamic pound1Ar;
  String? currencyNameEn;
  String? currencyNameAr;
  double? rate;
  dynamic userId;
  int? lastUpdateUserId;
  dynamic insertDate;
  String? lastUpdateDate;

  CurrencyEntity(
      {this.id,
      this.piaster3Ar,
      this.piaster2Ar,
      this.piaster3En,
      this.piaster2En,
      this.piaster1Ar,
      this.piaster1En,
      this.pound3Ar,
      this.pound3En,
      this.pound2En,
      this.pound2Ar,
      this.pound1En,
      this.pound1Ar,
      this.currencyNameEn,
      this.currencyNameAr,
      this.rate,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate});
}
