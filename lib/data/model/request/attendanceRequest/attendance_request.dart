class AttendanceRequest {
  String? idBl;
  String? timingBl;
  String? attendanceBl;
  String? departureBl;
  String? startAttendanceBl;
  String? endAttendanceBl;
  String? startDepartureBl;
  String? endDepartureBl;

  AttendanceRequest(
      {this.idBl,
      this.timingBl,
      this.attendanceBl,
      this.departureBl,
      this.startAttendanceBl,
      this.endAttendanceBl,
      this.startDepartureBl,
      this.endDepartureBl});

  AttendanceRequest.fromJson(Map<String, dynamic> json) {
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
    return _data;
  }
}
