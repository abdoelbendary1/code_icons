class AbsenceRequestDataModel {
  String? employeesIdBl;
  int? absenceTypeBl;
  String? fromDateBl;
  String? toDateBl;
  int? numDaysBl;
  String? notesBl;

  AbsenceRequestDataModel(
      {this.employeesIdBl,
      this.absenceTypeBl,
      this.fromDateBl,
      this.toDateBl,
      this.numDaysBl,
      this.notesBl});

  AbsenceRequestDataModel.fromJson(Map<String, dynamic> json) {
    if (json["employeesIdBL"] is String) {
      employeesIdBl = json["employeesIdBL"];
    }
    if (json["absenceTypeBL"] is int) {
      absenceTypeBl = json["absenceTypeBL"];
    }
    if (json["fromDateBL"] is String) {
      fromDateBl = json["fromDateBL"];
    }
    if (json["toDateBL"] is String) {
      toDateBl = json["toDateBL"];
    }
    if (json["numDaysBL"] is int) {
      numDaysBl = json["numDaysBL"];
    }
    if (json["notesBL"] is String) {
      notesBl = json["notesBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["employeesIdBL"] = employeesIdBl;
    _data["absenceTypeBL"] = absenceTypeBl;
    _data["fromDateBL"] = fromDateBl;
    _data["toDateBL"] = toDateBl;
    _data["numDaysBL"] = numDaysBl;
    _data["notesBL"] = notesBl;
    return _data;
  }
}
