import 'package:bloc/bloc.dart';
import 'package:code_icons/data/api/HR/Requests/attendence/IAttendance.dart';
import 'package:code_icons/data/api/HR/Requests/attendence/attendance_manager.dart';
import 'package:code_icons/data/api/HR/employee/Employee_interface.dart';
import 'package:code_icons/data/api/HR/employee/Employee_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/model/request/attendanceRequest/attendance_request.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/domain/entities/HR/attendanceResponse/attendance_response_entity.dart';
import 'package:code_icons/domain/entities/HR/employee/employee_entity.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:equatable/equatable.dart';

part 'attendace_state.dart';

class AttendaceCubit extends Cubit<AttendaceState> {
  AttendaceCubit() : super(AttendaceInitial());
  ControllerManager controllerManager = ControllerManager();

  String? attendanceBL;
  late String departureBL;
  late String startAttendanceBL;
  late String endAttendanceBL;
  late String startDepartureBL;
  late String endDepartureBL;

  AuthManagerInterface authManager = AuthManager(
    httpClient: injectHttpClient(),
    httpRequestHelper: injectHttpRequestHelper(),
    handleResponseHelper: injectHandleResponseHelper(),
  );

  EmployeeInterface employeeInterface = EmployeeManager(
      authManager: injectAuthManagerInterface(),
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper());
  late AuthResponseDM user;

  IAttendance iAttendance = AttendanceManager(
      authManager: injectAuthManagerInterface(),
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper());

  void addAttendanceSheet() async {
    emit(AttendaceInitial());
    var user = await authManager.getUser();
    var id = user?.id;

    try {
      var attendanceRequest = AttendanceRequest(
        timingBl: controllerManager.attendanceTimingBLController.text,
        attendanceBl: attendanceBL,
        departureBl: departureBL,
        startAttendanceBl: startAttendanceBL,
        endAttendanceBl: endAttendanceBL,
        startDepartureBl: startDepartureBL,
        endDepartureBl: endDepartureBL,
        idBl: id.toString(),
      );
      var either = await iAttendance.addAttendanceRequest(
          attendanceRequest: attendanceRequest);
      either.fold(
          (l) => emit(AddAttendaceSheetError(errorMessage: l.errorMessege)),
          (r) => emit(AddAttendaceSheetSuccess()));
    } catch (e) {
      emit(AddAttendaceSheetError(errorMessage: "يجب ادخال الوقت"));
    }
  }

  void getAttendanceEntity({required String id}) async {
    emit(GetAttendaceByIDLoading());
    var either = await iAttendance.getAttendanceRequestByID(id: id);
    either.fold(
        (l) => emit(GetAttendaceByIDError(errorMessage: l.errorMessege)),
        (r) => emit(GetAttendaceByIDSuccess(entity: r)));
  }

  void updateAttendanceById({required String id}) async {
    try {
      var attendanceRequest = AttendanceRequest(
        timingBl: controllerManager.attendanceTimingBLController.text,
        attendanceBl: attendanceBL,
        departureBl: departureBL,
        startAttendanceBl: startAttendanceBL,
        endAttendanceBl: endAttendanceBL,
        startDepartureBl: startDepartureBL,
        endDepartureBl: endDepartureBL,
        idBl: id.toString(),
      );
      var either = await iAttendance.updateAttendanceRequestByID(
          id: id, attendanceRequest: attendanceRequest);
      either.fold(
          (l) => emit(UpdateAttendaceSheetError(errorMessage: l.errorMessege)),
          (r) => emit(UpdateAttendaceSheetSuccess()));
    } catch (e) {
      emit(UpdateAttendaceSheetError(errorMessage: "يجب ادخال الوقت"));
    }
  }
}
