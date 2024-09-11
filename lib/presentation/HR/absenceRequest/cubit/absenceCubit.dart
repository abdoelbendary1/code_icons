import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'absenceState.dart';

class AbsenceRequestCubit extends Cubit<absenceRequestState> {
  AbsenceRequestCubit() : super(absenceRequestInitial());

  void initialize() async {
    getstatusNamess();
    /*   getVacationTypes();
    var employee = await HomeScreenViewModel(
            fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase())
        .getCachedEmployeeEntity();
    updateVacationDaysValue(employeeEntity: employee);
  }

  void getVacationTypes() async {
    var either = await vacationInterface.getAllVacationtTypes();
    either.fold((l) => emit(GetVactionTypesError(errorMessage: l.errorMessege)),
        (r) {
      vacationTypeEntityList = r;
      emit(GetVactionTypesSuccess(vacationTypeEntityList: r));
    }); */
  }

  final formKey = GlobalKey<FormState>();
  Map<String, String> dateStorageMap = {
    'UnlimitedPaymentReceitDateController': '',
  };
/*   VacationInterface vacationInterface = vacationManager(
      authManager: AuthManager(
        httpClient: injectHttpClient(),
        httpRequestHelper: injectHttpRequestHelper(),
        handleResponseHelper: injectHandleResponseHelper(),
      ),
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper());
  List<VacationTypeEntity> vacationTypeEntityList = [];
  ControllerManager controllerManager = ControllerManager();
  AuthManagerInterface authManager = AuthManager(
    httpClient: injectHttpClient(),
    httpRequestHelper: injectHttpRequestHelper(),
    handleResponseHelper: injectHandleResponseHelper(),
  ); */

  DateTime convertStringToDateTime({required String input}) {
    DateFormat inputFormat = DateFormat('yyyy/MM/dd');
    // Parse the input string into a DateTime object
    DateTime dateTime = inputFormat.parse(input);
    return dateTime;
    /*  // Define the output format
    DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return outputFormat.parse(input); */
  }

  int calculateVacationDays({String? startDate, String? returnDate}) {
    DateTime startDateTime = convertStringToDateTime(input: startDate!);
    DateTime returnDateTime = convertStringToDateTime(input: returnDate!);
    return returnDateTime.difference(startDateTime).inDays;
  }

  void updateVacationDaysController({String? startDate, String? returnDate}) {
    if (returnDate!.isEmpty) {
    } else {
      int vacationDays =
          calculateVacationDays(startDate: startDate, returnDate: returnDate);
      /*   controllerManager.vacationDaysController.text = vacationDays.toString(); */
    }
  }

  /* void updateVacationDaysValue({EmployeeEntity? employeeEntity}) {
    if (employeeEntity?.dayValueBl == null) {
      controllerManager.remainingVacationsController.text = "0";
    } else {
      controllerManager.remainingVacationsController.text =
          employeeEntity!.dayValueBl.toString();
    }
  } */

  /*  Map<String, String> dateStorageMap = {
    'UnlimitedPaymentReceitDateController': '',
  };
 */
  List<Map<String, dynamic>> status = [
    {
      "id": 1,
      "Subject": 'بإذن',
    },
    {
      "id": 2,
      "Subject": ' من غير إذن',
    },
  ];
  late int selectedStatusBl;
  List<String> statusNames = [];
  void getstatusNamess() {
    for (var trade in status) {
      statusNames.add(trade['Subject']);
    }
  }

  int getIdBySubject(String key) {
    for (var trade in status) {
      if (trade['Subject'] == key) {
        return trade['id'];
      }
    }
    return 1;
  }

/*   late VacationTypeEntity selectedVacationType;
 */
  void addVacationRequest() async {
    /*   if (formKey.currentState!.validate()) {
      var user = await authManager.getUser();
      AddVacationRequestDataModel addVacationRequestDataModel =
          AddVacationRequestDataModel(
        amountBl: int.parse(controllerManager.vacationDaysController.text),
        employeesIdBl: user!.id!.toString(),
        fromDateBl: controllerManager.vacationStartDateController.text,
        notesBl: controllerManager.vacationNotesController.text,
        numDaysBl: int.parse(controllerManager.vacationDaysController.text),
        statusBl: selectedStatusBl,
        toDateBl: controllerManager.vacationReturnDateController.text,
        vacationTypeIdBl: selectedVacationType.idBl,
      );
      var either = await vacationInterface.addVacationRequest(
          vacationRequestDataModel: addVacationRequestDataModel);
      either.fold(
          (l) => emit(addVacationRequestError(errorMessage: l.errorMessege)),
          (r) {
        print(r);
        emit(addVacationRequestSuccess());
      });
    } */
  }
}
