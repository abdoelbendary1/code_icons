import 'package:bloc/bloc.dart';
import 'package:code_icons/data/api/HR/Requests/Loan/ILoan.dart';
import 'package:code_icons/data/api/HR/Requests/Loan/Loan_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/model/request/LoanRequest/loan_request_data_model.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'Loan_order_state.dart';

class LoanRequestCubit extends Cubit<LoanRequestState> {
  LoanRequestCubit() : super(LoanRequestInitial());

  void initialize() async {
    getstatusNamess();
    /* var employee = await HomeScreenViewModel(
            fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase())
        .getCachedEmployeeEntity(); */
    /* updateVacationDaysValue(employeeEntity: employee); */
  }

  final formKey = GlobalKey<FormState>();
  Map<String, String> dateStorageMap = {
    'UnlimitedPaymentReceitDateController': '',
  };
  AuthManagerInterface authManager = AuthManager(
    httpClient: injectHttpClient(),
    httpRequestHelper: injectHttpRequestHelper(),
    handleResponseHelper: injectHandleResponseHelper(),
  );
  ILoan iLoan = LoanManager(
      authManager: AuthManager(
        httpClient: injectHttpClient(),
        httpRequestHelper: injectHttpRequestHelper(),
        handleResponseHelper: injectHandleResponseHelper(),
      ),
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper());
  /*  List<VacationTypeEntity> vacationTypeEntityList = []; */
  ControllerManager controllerManager = ControllerManager();

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
      "Subject": ' قيد إنتظار',
    },
    {
      "id": 2,
      "Subject": ' مقبول',
    },
    {
      "id": 3,
      "Subject": ' مرفوض',
    }
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

  double calculateValueAdvanceBL() {
    double amountBl = double.parse(controllerManager.loanValueController.text);
    double numAdvanceBl =
        double.parse(controllerManager.numOfLoanAdvanceController.text);
    double valueAdvanceBl = amountBl / numAdvanceBl;
    return valueAdvanceBl;
  }

  void addVacationRequest() async {
    if (formKey.currentState!.validate()) {
      var user = await authManager.getUser();
      LoanRequestDataModel loanRequestDataModel = LoanRequestDataModel(
        amountBl: double.parse(controllerManager.loanValueController.text),
        employeesIdBl: user!.id!.toString(),
        requestDateBl: controllerManager.loanRequestDateController.text,
        startDateBl: controllerManager.loanStartDateController.text,
        statusBl: selectedStatusBl,
        numAdvanceBl:
            double.parse(controllerManager.numOfLoanAdvanceController.text),
        valueAdvanceBl: calculateValueAdvanceBL().toString(),
      );

      var either = await iLoan.addLoanRequest(
          loanRequestDataModel: loanRequestDataModel);
      either.fold(
          (l) => emit(addLoanRequestError(errorMessage: l.errorMessege)), (r) {
        print(r);
        emit(addLoanRequestSuccess());
      });
    }
  }
}
