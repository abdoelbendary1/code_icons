import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/sysSettings/ISysSetting.dart';
import 'package:code_icons/data/model/response/auth_respnose/loginScreen.dart';
import 'package:code_icons/domain/entities/HR/employee/employee_entity.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/sectionEntity/sectionEntity.dart';
import 'package:code_icons/domain/entities/settings/StForm/st_form_entity.dart';
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
  ISysSettings iSysSettings = injectISysSettings();

  late EmployeeEntity employeeEntity;
  ControllerManager controllerManager = ControllerManager();

  FetchEmployeeDataByIDUseCase fetchEmployeeDataByIDUseCase;
  List<LoginScreensDM> screens = [];
  getScreen() async {
    screens = await getLoginScreens();
  }

  Future<List<LoginScreensDM>> getLoginScreens() async {
    var box = await Hive.openBox<LoginScreensDM>('loginScreensBox');

    // Get all the screens stored in the box
    List<LoginScreensDM> screens = box.values.toList();

    return screens;
  }

  void updateSectionsMapBasedOnSettings({
    required Map<String, SectionEntity> sourceMap,
    required Map<String, SectionEntity> targetMap,
    required SettingsEntity settingsEntity,
  }) async {
    List<LoginScreensDM> screens = await getLoginScreens();

    // Example condition for 'collections'
    if (settingsEntity.collections!.toLowerCase() == 'collections yes') {
      if (screens.any(
          (element) => element.modules == "Collection" && screens.isNotEmpty)) {
        targetMap['collections'] = sourceMap['collections']!;
      } else if (screens.isEmpty) {
        targetMap['collections'] = sourceMap['collections']!;
      }
    }
    if (settingsEntity.finance!.toLowerCase() == 'finance yes') {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['finance'] = sourceMap['finance']!;
      } else if (screens.isEmpty) {
        targetMap['finance'] = sourceMap['finance']!;
      }
    }
    if (settingsEntity.cashInOut!.toLowerCase() ==
        'cashInOut yes'.toLowerCase()) {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['cashInOut'] = sourceMap['cashInOut']!;
      } else if (screens.isEmpty) {
        targetMap['cashInOut'] = sourceMap['cashInOut']!;
      }
    }
    if (settingsEntity.purchases!.toLowerCase() == 'purchases yes') {
      if (screens
          .any((element) => element.modules == "PR" && screens.isNotEmpty)) {
        targetMap['purchases'] = sourceMap['purchases']!;
      } else if (screens.isEmpty) {
        targetMap['purchases'] = sourceMap['purchases']!;
      }
    }
    if (settingsEntity.sales!.toLowerCase() == 'sales yes') {
      if (screens
          .any((element) => element.modules == "SL" && screens.isNotEmpty)) {
        targetMap['sales'] = sourceMap['SL']!;
      } else if (screens.isEmpty) {
        targetMap['sales'] = sourceMap['SL']!;
      }
    }
    if (settingsEntity.costructions!.toLowerCase() ==
        'costructions yes'.toLowerCase()) {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['costructions'] = sourceMap['costructions']!;
      } else if (screens.isEmpty) {
        targetMap['costructions'] = sourceMap['costructions']!;
      }
    }
    if (settingsEntity.charterparty!.toLowerCase() ==
        'charterparty yes'.toLowerCase()) {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['charterparty'] = sourceMap['charterparty']!;
      } else if (screens.isEmpty) {
        targetMap['charterparty'] = sourceMap['charterparty']!;
      }
    }
    if (settingsEntity.humanResources!.toLowerCase() ==
        "humanResources yes".toLowerCase()) {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['humanResources'] = sourceMap['humanResources']!;
      } else if (screens.isEmpty) {
        targetMap['humanResources'] = sourceMap['humanResources']!;
      }
    }
    if (settingsEntity.stores!.toLowerCase() == 'stores yes') {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['stores'] = sourceMap['stores']!;
      } else if (screens.isEmpty) {
        targetMap['stores'] = sourceMap['stores']!;
      }
    }
    if (settingsEntity.reports!.toLowerCase() == 'reports yes') {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['reports'] = sourceMap['reports']!;
      } else if (screens.isEmpty) {
        targetMap['reports'] = sourceMap['reports']!;
      }
    }
    /*  if (settingsEntity.settings!.toLowerCase() == 'settings yes') {
      targetMap['settings'] = sourceMap['settings']!;
    } */
    if (settingsEntity.realStateInvestments!.toLowerCase() ==
        'realStateInvestments yes'.toLowerCase()) {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['realStateInvestments'] = sourceMap['realStateInvestments']!;
      }
    }
    if (settingsEntity.imports!.toLowerCase() == 'imports yes') {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['imports'] = sourceMap['imports']!;
      }
    }
    if (settingsEntity.hospital!.toLowerCase() == 'hospital yes') {
      if (screens
          .any((element) => element.modules == "" && screens.isNotEmpty)) {
        targetMap['hospital'] = sourceMap['hospital']!;
      }
    }
    /* targetMap['ships'] = sourceMap['ships']!; */
    /* targetMap['storage'] = sourceMap['storage']!; */

    // Add other conditions for different sections
  }

  List<LoginScreensDM>? userScreens = [];

  late var authResponseBox;
  late Future<AuthRepoEntity?> authResponse;

  /*  void getScreens() async {
    // Open the box where AuthResponseDM objects are stored
    authResponseBox = await Hive.openBox('userBox');
    userScreens = await authResponseBox.get('screens') as List<LoginScreensDM>?;
// Retrieve the AuthResponseDM object
  }
 */
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

  List<StFormEntity> forms = [];

  loadForms() async {
    try {
      emit(HomeScreenLoading());

      var either = await iSysSettings.getStFormData();
      either.fold((l) {
        emit(HomeScreenError(message: "Failed to load menu items"));
      }, (r) async {
        forms = r;
        print(r.first.formName);
/*         emit(GetScreensSuccess(stFormEntityList: r));
 */
      });
    } catch (e) {
      emit(HomeScreenError(message: "Failed to load menu items"));
    }
  }

  void loadMenu() async {
    emit(HomeScreenInitial());
    loadForms();
    try {
      /*   var cachedSettings = await _getCachedSettingsEntity();
      if (cachedSettings != null) {
        updateSectionsMapBasedOnSettings(
            sourceMap: menus,
            targetMap: updatedSectionsMap,
            settingsEntity: cachedSettings);

        emit(HomeScreenSuccess(
            menus: updatedSectionsMap, settingsEntity: cachedSettings));
        return;
      } */
      emit(HomeScreenLoading());

      var either = await ApiManager.getInstance().fetchSettingsData();
      either.fold((l) {
        emit(HomeScreenError(message: "Failed to load menu items"));
      }, (r) async {
        /*   var user = await authManager.getUser();
        var token = user!.accessToken; */
/*         fetchEmployeeDataByID();
 */
        updateSectionsMapBasedOnSettings(
            sourceMap: menus, targetMap: updatedSectionsMap, settingsEntity: r);

        // Cache the fetched settings
        /* await _cacheSettingsEntity(r); */

        emit(HomeScreenSuccess(menus: updatedSectionsMap, settingsEntity: r));
      });
    } catch (e) {
      emit(HomeScreenError(message: "Failed to load menu items"));
    }
  }

  
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
