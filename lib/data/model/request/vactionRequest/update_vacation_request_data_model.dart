
class UpdateVacationRequestDataModel {
  String? fromDateBl;
  String? employeesIdBl;
  String? vacationTypeIdBl;
  int? amountBl;
  String? toDateBl;
  int? numDaysBl;
  String? notesBl;

  UpdateVacationRequestDataModel({this.fromDateBl, this.employeesIdBl, this.vacationTypeIdBl, this.amountBl, this.toDateBl, this.numDaysBl, this.notesBl});

  UpdateVacationRequestDataModel.fromJson(Map<String, dynamic> json) {
    if(json["fromDateBL"] is String) {
      fromDateBl = json["fromDateBL"];
    }
    if(json["employeesIdBL"] is String) {
      employeesIdBl = json["employeesIdBL"];
    }
    if(json["vacationTypeIdBL"] is String) {
      vacationTypeIdBl = json["vacationTypeIdBL"];
    }
    if(json["amountBL"] is int) {
      amountBl = json["amountBL"];
    }
    if(json["toDateBL"] is String) {
      toDateBl = json["toDateBL"];
    }
    if(json["numDaysBL"] is int) {
      numDaysBl = json["numDaysBL"];
    }
    if(json["notesBL"] is String) {
      notesBl = json["notesBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fromDateBL"] = fromDateBl;
    _data["employeesIdBL"] = employeesIdBl;
    _data["vacationTypeIdBL"] = vacationTypeIdBl;
    _data["amountBL"] = amountBl;
    _data["toDateBL"] = toDateBl;
    _data["numDaysBL"] = numDaysBl;
    _data["notesBL"] = notesBl;
    return _data;
  }
}