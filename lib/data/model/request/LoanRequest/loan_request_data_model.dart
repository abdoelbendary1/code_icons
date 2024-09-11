
class LoanRequestDataModel {
  int? statusBl;
  String? employeesIdBl;
  double? amountBl;
  double? numAdvanceBl;
  String? valueAdvanceBl;
  String? requestDateBl;
  String? startDateBl;

  LoanRequestDataModel({this.statusBl, this.employeesIdBl, this.amountBl, this.numAdvanceBl, this.valueAdvanceBl, this.requestDateBl, this.startDateBl});

  LoanRequestDataModel.fromJson(Map<String, dynamic> json) {
    if(json["statusBL"] is int) {
      statusBl = json["statusBL"];
    }
    if(json["employeesIdBL"] is String) {
      employeesIdBl = json["employeesIdBL"];
    }
    if(json["amountBL"] is double) {
      amountBl = json["amountBL"];
    }
    if(json["numAdvanceBL"] is double) {
      numAdvanceBl = json["numAdvanceBL"];
    }
    if(json["valueAdvanceBL"] is String) {
      valueAdvanceBl = json["valueAdvanceBL"];
    }
    if(json["requestDateBL"] is String) {
      requestDateBl = json["requestDateBL"];
    }
    if(json["startDateBL"] is String) {
      startDateBl = json["startDateBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["statusBL"] = statusBl;
    _data["employeesIdBL"] = employeesIdBl;
    _data["amountBL"] = amountBl;
    _data["numAdvanceBL"] = numAdvanceBl;
    _data["valueAdvanceBL"] = valueAdvanceBl;
    _data["requestDateBL"] = requestDateBl;
    _data["startDateBL"] = startDateBl;
    return _data;
  }
}