class PaymentValuesEntity {
  String? yearsOfRepayment;
  List<int>? paidYears;
  double? compensation;
  double? late;
  double? current;
  double? different;
  double? total;

  PaymentValuesEntity(
      {this.yearsOfRepayment,
      this.paidYears,
      this.compensation,
      this.late,
      this.current,
      this.different,
      this.total});
}
