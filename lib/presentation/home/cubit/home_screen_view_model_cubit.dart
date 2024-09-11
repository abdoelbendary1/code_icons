import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/domain/entities/HR/employee/employee_entity.dart';
import 'package:code_icons/domain/entities/sectionEntity/sectionEntity.dart';
import 'package:code_icons/domain/entities/settings/settings_entity.dart';
import 'package:code_icons/domain/use_cases/HR/Employee/fetchEmployeeDataByID.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'home_screen_view_model_state.dart';

class HomeScreenViewModel extends Cubit<HomeScreenViewModelState> {
  HomeScreenViewModel({
    required this.fetchEmployeeDataByIDUseCase,
  }) : super(HomeScreenInitial());
  Map<String, SectionEntity> menus = AppLocalData.menus;
  static Map<String, SectionEntity> updatedSectionsMap = {};
  AuthManagerInterface authManager = AuthManager(
      httpClient: injectHttpClient(),
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper());

  late EmployeeEntity employeeEntity;
  ControllerManager controllerManager = ControllerManager();

  FetchEmployeeDataByIDUseCase fetchEmployeeDataByIDUseCase;

  void updateSectionsMapBasedOnSettings({
    required Map<String, SectionEntity> sourceMap,
    required Map<String, SectionEntity> targetMap,
    required SettingsEntity settingsEntity,
  }) {
    // Example condition for 'collections'
    if (settingsEntity.collections!.toLowerCase() == 'collections yes') {
      targetMap['collections'] = sourceMap['collections']!;
    }
    if (settingsEntity.finance!.toLowerCase() == 'finance yes') {
      targetMap['finance'] = sourceMap['finance']!;
    }
    if (settingsEntity.cashInOut!.toLowerCase() ==
        'cashInOut yes'.toLowerCase()) {
      targetMap['cashInOut'] = sourceMap['cashInOut']!;
    }
    if (settingsEntity.purchases!.toLowerCase() == 'purchases yes') {
      targetMap['purchases'] = sourceMap['purchases']!;
    }
    if (settingsEntity.sales!.toLowerCase() == 'sales yes') {
      targetMap['sales'] = sourceMap['sales']!;
    }
    if (settingsEntity.costructions!.toLowerCase() ==
        'costructions yes'.toLowerCase()) {
      targetMap['costructions'] = sourceMap['costructions']!;
    }
    if (settingsEntity.charterparty!.toLowerCase() ==
        'charterparty yes'.toLowerCase()) {
      targetMap['charterparty'] = sourceMap['charterparty']!;
    }
    if (settingsEntity.humanResources!.toLowerCase() ==
        "humanResources yes".toLowerCase()) {
      targetMap['humanResources'] = sourceMap['humanResources']!;
    }
    if (settingsEntity.stores!.toLowerCase() == 'stores yes') {
      targetMap['stores'] = sourceMap['stores']!;
    }
    if (settingsEntity.reports!.toLowerCase() == 'reports yes') {
      targetMap['reports'] = sourceMap['reports']!;
    }
    /*  if (settingsEntity.settings!.toLowerCase() == 'settings yes') {
      targetMap['settings'] = sourceMap['settings']!;
    } */
    if (settingsEntity.realStateInvestments!.toLowerCase() ==
        'realStateInvestments yes'.toLowerCase()) {
      targetMap['realStateInvestments'] = sourceMap['realStateInvestments']!;
    }
    if (settingsEntity.imports!.toLowerCase() == 'imports yes') {
      targetMap['imports'] = sourceMap['imports']!;
    }
    if (settingsEntity.hospital!.toLowerCase() == 'hospital yes') {
      targetMap['hospital'] = sourceMap['hospital']!;
    }

    // Add other conditions for different sections
  }

  String convertToDateString(String input) {
    try {
      DateTime dateTime = DateTime.parse(input);
      String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
      return formattedDate;
    } catch (e) {
      return 'Invalid date format';
    }
  }

  Future<void> _cacheSettingsEntity(SettingsEntity settingsEntity) async {
    var box = await Hive.openBox<SettingsEntity>('settingsBox');
    await box.put('settings', settingsEntity);
  }

  Future<SettingsEntity?> _getCachedSettingsEntity() async {
    var box = await Hive.openBox<SettingsEntity>('settingsBox');
    return box.get('settings');
  }

  Map<int, String> gender = {1: 'ذكر', 2: 'انثى'};
  String? getGenderByID({required int id, required Map<int, dynamic> map}) {
    return map[id];
  }

  Map<int, String> socialStatus = {
    1: 'اعزب',
    2: 'متزوج',
  };
  String? getSocialStatusByID(
      {required int id, required Map<int, dynamic> map}) {
    return map[id];
  }

  void loadMenu() async {
    emit(HomeScreenInitial());
    try {
      var cachedSettings = await _getCachedSettingsEntity();
      if (cachedSettings != null) {
        updateSectionsMapBasedOnSettings(
            sourceMap: menus,
            targetMap: updatedSectionsMap,
            settingsEntity: cachedSettings);

        emit(HomeScreenSuccess(
            menus: updatedSectionsMap, settingsEntity: cachedSettings));
        return;
      }
      emit(HomeScreenLoading());

      var either = await ApiManager.getInstance().fetchSettingsData();
      either.fold(
          (l) => emit(HomeScreenError(message: "Failed to load menu items")),
          (r) async {
        /*   var user = await authManager.getUser();
        var token = user!.accessToken; */
/*         fetchEmployeeDataByID();
 */
        updateSectionsMapBasedOnSettings(
            sourceMap: menus, targetMap: updatedSectionsMap, settingsEntity: r);

        // Cache the fetched settings
        await _cacheSettingsEntity(r);

        emit(HomeScreenSuccess(menus: updatedSectionsMap, settingsEntity: r));
      });
    } catch (e) {
      emit(HomeScreenError(message: "Failed to load menu items"));
    }
  }

  /* void loadMenu() async {
    try {
      var either = await ApiManager.getInstance().fetchSettingsData();
      either.fold(
          (l) => emit(HomeScreenError(message: "Failed to load menu items")),
          (r) async {
        var user = await authManager.getUser();
        var token = user!.accessToken;
        /*   String token = SharedPrefrence.getData(key: "accessToken") as String; */
        print(token);
        updateSectionsMapBasedOnSettings(
            sourceMap: menus, targetMap: updatedSectionsMap, settingsEntity: r);

        emit(HomeScreenSuccess(menus: updatedSectionsMap, settingsEntity: r));
      });
      /*  emit(HomeScreenSuccess(menus: menus)); */
    } catch (e) {
      emit(HomeScreenError(message: "Failed to load menu items"));
    }
  } */
  Future<void> _cacheEmployeeEntity(EmployeeEntity employeeEntity) async {
    var box = await Hive.openBox<EmployeeEntity>('employeeBox');
    await box.put('employee', employeeEntity);
  }

  EmployeeEntity? employee;

  Future<EmployeeEntity?> getCachedEmployeeEntity() async {
    var box = await Hive.openBox<EmployeeEntity>('employeeBox');
    employee = box.get('employee');
    return employee;
  }

  void fetchEmployeeData() async {
    try {
      // Check if the data is cached
      var cachedEmployee = await getCachedEmployeeEntity();
      if (cachedEmployee != null) {
        employee = cachedEmployee;

        // If cached, use the cached data
        updateProfile(employeeEntity: cachedEmployee);
        /*  emit(GetEmployeeDataSuccess(employeeEntity: cachedEmployee)); */
        return;
      }

      // If not cached, fetch the data from the API
      var user = await authManager.getUser();
      var either =
          await fetchEmployeeDataByIDUseCase.getEmployeeByID(id: user!.id!);
/*       emit(GetEmployeeDataLoading());
 */
      either.fold((l) {
/*         emit(GetEmployeeDataError(message: l.errorMessege));
 */
      }, (r) async {
        // Cache the fetched employee data
        await _cacheEmployeeEntity(r);

        updateProfile(employeeEntity: r);
        employee = r;
/*         emit(GetEmployeeDataSuccess(employeeEntity: r));
 */
      });
    } catch (e) {
/*       emit(GetEmployeeDataError(message: e.toString()));
 */
    }
  }

  void fetchEmployeeDataByID(/* {required int id} */) async {
    try {
      // Check if the data is cached
      var cachedEmployee = await getCachedEmployeeEntity();
      if (cachedEmployee != null) {
        employee = cachedEmployee;
        // If cached, use the cached data
        emit(GetEmployeeDataLoading());
        /*   updateProfile(employeeEntity: cachedEmployee); */
        emit(GetEmployeeDataSuccess(employeeEntity: cachedEmployee));
        return;
      }

      // If not cached, fetch the data from the API
      var user = await authManager.getUser();
      var either =
          await fetchEmployeeDataByIDUseCase.getEmployeeByID(id: user!.id!);
      emit(GetEmployeeDataLoading());
      either.fold((l) {
        emit(GetEmployeeDataError(message: l.errorMessege));
      }, (r) async {
        // Cache the fetched employee data
        await _cacheEmployeeEntity(r);

        updateProfile(employeeEntity: r);
        employee = r;
        emit(GetEmployeeDataSuccess(employeeEntity: r));
      });
    } catch (e) {
      emit(GetEmployeeDataError(message: e.toString()));
    }
  }

  /*  void fetchEmployeeDataByID(/* {required int id} */) async {
    emit(GetEmployeeDataLoading());

    var user = await authManager.getUser();
    var either =
        await fetchEmployeeDataByIDUseCase.getEmployeeByID(id: user!.id!);
    either.fold((l) => emit(GetEmployeeDataError(message: l.errorMessege)),
        (r) {
      /*   employeeEntity = r; */
      updateProfile(employeeEntity: r);
      emit(GetEmployeeDataSuccess(employeeEntity: r));
    });
  } */

  void updateProfile({required EmployeeEntity employeeEntity}) {
    ControllerManager controllerManager = ControllerManager();

    controllerManager.employeeCodeController.text = employeeEntity.codeBl ?? '';
    controllerManager.employeeNameController.text =
        employeeEntity.employeeNameBl ?? '';
    controllerManager.employeeNationalIdController.text =
        employeeEntity.nationalIdBl ?? '';
    controllerManager.employeeJobTitleController.text =
        employeeEntity.jobNameBl ?? '';
    controllerManager.employeeDepartmentController.text =
        employeeEntity.departmentNameBl ?? '';
    controllerManager.employeeEducationController.text =
        employeeEntity.qualificationBl?.toString() ?? '';
    controllerManager.employeeEducationNameController.text =
        employeeEntity.qualificationNameBl ?? '';
    controllerManager.employeeGenderController.text =
        getGenderByID(id: employeeEntity.genderBl!, map: gender).toString();
    controllerManager.employeeSocialStatusController.text = getSocialStatusByID(
            id: employeeEntity.maritalStatusBl!, map: socialStatus)
        .toString();
    controllerManager.employeePhoneNumberController.text =
        employeeEntity.phoneNumBl?.toString() ?? '';
    controllerManager.employeeWorkStartDateController.text =
        convertToDateString(employeeEntity.startDateBl ?? "");
    controllerManager.employeeAddressController.text =
        employeeEntity.addressBl?.toString() ?? '';
  }
}
