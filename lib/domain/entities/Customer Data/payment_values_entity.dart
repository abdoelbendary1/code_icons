class PaymentValuesEntity {
  String? yearsOfRepayment;
  List<dynamic>? paidYears;
  double? compensation;
  double? activity;
  double? late;
  double? current;
  double? different;
  double? advPay;
  double? latePay;

  double? total;
  double? clientId;
  double? tradeRegistryTypeBl;
  String? clientName;
  String? clientAddress;
  double? capital;
  String? message;

  PaymentValuesEntity({
    this.yearsOfRepayment,
    this.paidYears,
    this.compensation,
    this.activity,
    this.late,
    this.current,
    this.different,
    this.advPay,
    this.latePay,
    this.total,
    this.clientId,
    this.tradeRegistryTypeBl,
    this.clientName,
    this.clientAddress,
    this.capital,
    this.message,
  });
}
