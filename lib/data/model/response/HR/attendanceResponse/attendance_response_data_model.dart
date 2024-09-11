import 'package:code_icons/domain/entities/HR/attendanceResponse/attendance_response_entity.dart';

class AttendanceResponseDataModel extends AttendanceResponseEntity {
  AttendanceResponseDataModel(
      {super.idBl,
      super.timingBl,
      super.attendanceBl,
      super.departureBl,
      super.startAttendanceBl,
      super.endAttendanceBl,
      super.startDepartureBl,
      super.endDepartureBl,
      super.insertDate});

  AttendanceResponseDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is String) {
      idBl = json["idBL"];
    }
    if (json["timingBL"] is String) {
      timingBl = json["timingBL"];
    }
    if (json["attendanceBL"] is String) {
      attendanceBl = json["attendanceBL"];
    }
    if (json["departureBL"] is String) {
      departureBl = json["departureBL"];
    }
    if (json["startAttendanceBL"] is String) {
      startAttendanceBl = json["startAttendanceBL"];
    }
    if (json["endAttendanceBL"] is String) {
      endAttendanceBl = json["endAttendanceBL"];
    }
    if (json["startDepartureBL"] is String) {
      startDepartureBl = json["startDepartureBL"];
    }
    if (json["endDepartureBL"] is String) {
      endDepartureBl = json["endDepartureBL"];
    }
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["timingBL"] = timingBl;
    _data["attendanceBL"] = attendanceBl;
    _data["departureBL"] = departureBl;
    _data["startAttendanceBL"] = startAttendanceBl;
    _data["endAttendanceBL"] = endAttendanceBl;
    _data["startDepartureBL"] = startDepartureBl;
    _data["endDepartureBL"] = endDepartureBl;
    _data["insertDate"] = insertDate;
    return _data;
  }
}
