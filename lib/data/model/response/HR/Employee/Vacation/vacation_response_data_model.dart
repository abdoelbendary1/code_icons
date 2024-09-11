import 'package:code_icons/domain/entities/HR/Vacation/vacation_response_entity.dart';

class VacationResponseDataModel extends VacationResponseEntity {
  VacationResponseDataModel({
    super.idBl,
    super.codeBl,
    super.employeesIdBl,
    super.employeesNameBl,
    super.vacationTypeIdBl,
    super.vacationTypeBl,
    super.amountBl,
    super.fromDateBl,
    super.toDateBl,
    super.numDaysBl,
    super.statusBl,
    super.notesBl,
    super.insertDate,
  });

  VacationResponseDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is String) {
      idBl = json["idBL"];
    }
    if (json["codeBL"] is String) {
      codeBl = json["codeBL"];
    }
    if (json["employeesIdBL"] is int) {
      employeesIdBl = json["employeesIdBL"];
    }
    if (json["employeesNameBL"] is String) {
      employeesNameBl = json["employeesNameBL"];
    }
    if (json["vacationTypeIdBL"] is int) {
      vacationTypeIdBl = json["vacationTypeIdBL"];
    }
    if (json["vacationTypeBL"] is String) {
      vacationTypeBl = json["vacationTypeBL"];
    }
    if (json["amountBL"] is int) {
      amountBl = json["amountBL"];
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
    if (json["statusBL"] is int) {
      statusBl = json["statusBL"];
    }
    if (json["notesBL"] is String) {
      notesBl = json["notesBL"];
    }
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["codeBL"] = codeBl;
    _data["employeesIdBL"] = employeesIdBl;
    _data["employeesNameBL"] = employeesNameBl;
    _data["vacationTypeIdBL"] = vacationTypeIdBl;
    _data["vacationTypeBL"] = vacationTypeBl;
    _data["amountBL"] = amountBl;
    _data["fromDateBL"] = fromDateBl;
    _data["toDateBL"] = toDateBl;
    _data["numDaysBL"] = numDaysBl;
    _data["statusBL"] = statusBl;
    _data["notesBL"] = notesBl;
    _data["insertDate"] = insertDate;
    return _data;
  }
}
