import 'package:bloc/bloc.dart';
import 'package:code_icons/data/api/HR/Requests/attendence/IAttendance.dart';
import 'package:code_icons/domain/entities/HR/attendanceResponse/attendance_response_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'all_attendance_state.dart';

class AllAttendanceCubit extends Cubit<AllAttendanceState> {
  AllAttendanceCubit({
    required this.iAttendance,
  }) : super(AllAttendanceInitial());

  IAttendance iAttendance;

  void getAllAttendance({required DateTime date}) async {
    emit(AllAttendanceInitial());
    var either = await iAttendance.getAllAttendanceRequests();
    either.fold(
        (l) => emit(
              GetAllAttendanceError(errorMsg: l.errorMessege),
            ), (r) {
      List<AttendanceResponseEntity> filteredList =
          filterAttendanceByDay(list: r, date: date);
      if (filteredList.isEmpty) {
        emit(GetAllAttendanceError(errorMsg: "لا يوجد توقيتات"));
      } else {
        emit(
          GetAllAttendanceSuccess(attendances: filteredList),
        );
      }
    });
  }

  void deleteAttendanceRequest(
      {required String attendanceID, required DateTime date}) async {
    emit(AllAttendanceInitial());

    var delete =
        await iAttendance.deleteAttendanceRequest(attendanceID: attendanceID);
    delete.fold((l) {
      print(l.errorMessege);
      emit(
        DeleteAttendanceError(errorMsg: l.errorMessege),
      );
    }, (r) async {
      getAllAttendance(date: date);
      emit(DeleteAttendanceSuccess());
    });
  }

  String formatDate(DateTime date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(date);
  }

  String getFormatedDate(String date) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSS");
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  List<AttendanceResponseEntity> filterAttendanceByDay({
    required List<AttendanceResponseEntity> list,
    required DateTime date,
  }) {
    List<AttendanceResponseEntity> newList = list
        .where((element) =>
            getFormatedDate(element.insertDate!) == formatDate(date))
        .toList();
    return newList;
  }

  String getAttendanceTime(String date) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('HH:mm');
    return outputFormat.format(inputDate);
  }
}
