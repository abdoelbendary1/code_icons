class AddVacationRequestDataModel {
  String? fromDateBl;
  String? toDateBl;
  int? numDaysBl;
  String? employeesIdBl;
  String? vacationTypeIdBl;
  int? amountBl;
  int? statusBl;
  String? notesBl;

  AddVacationRequestDataModel(
      {this.fromDateBl,
      this.toDateBl,
      this.numDaysBl,
      this.employeesIdBl,
      this.vacationTypeIdBl,
      this.amountBl,
      this.statusBl,
      this.notesBl});

  AddVacationRequestDataModel.fromJson(Map<String, dynamic> json) {
    if (json["fromDateBL"] is String) {
      fromDateBl = json["fromDateBL"];
    }
    if (json["toDateBL"] is String) {
      toDateBl = json["toDateBL"];
    }
    if (json["numDaysBL"] is int) {
      numDaysBl = json["numDaysBL"];
    }
    if (json["employeesIdBL"] is String) {
      employeesIdBl = json["employeesIdBL"];
    }
    if (json["vacationTypeIdBL"] is String) {
      vacationTypeIdBl = json["vacationTypeIdBL"];
    }
    if (json["amountBL"] is int) {
      amountBl = json["amountBL"];
    }
    if (json["statusBL"] is int) {
      statusBl = json["statusBL"];
    }
    if (json["notesBL"] is String) {
      notesBl = json["notesBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fromDateBL"] = fromDateBl;
    _data["toDateBL"] = toDateBl;
    _data["numDaysBL"] = numDaysBl;
    _data["employeesIdBL"] = employeesIdBl;
    _data["vacationTypeIdBL"] = vacationTypeIdBl;
    _data["amountBL"] = amountBl;
    _data["statusBL"] = statusBl;
    _data["notesBL"] = notesBl;
    return _data;
  }
}
