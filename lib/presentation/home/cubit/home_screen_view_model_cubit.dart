import 'package:bloc/bloc.dart';
import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/model/response/settings/settings_data_model.dart';
import 'package:code_icons/domain/entities/sectionEntity/sectionEntity.dart';
import 'package:code_icons/domain/entities/settings/settings_entity.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:code_icons/presentation/utils/shared_prefrence.dart';

part 'home_screen_view_model_state.dart';

class HomeScreenViewModel extends Cubit<HomeScreenViewModelState> {
  HomeScreenViewModel() : super(HomeScreenInitial());
  Map<String, SectionEntity> menus = AppLocalData.menus;
  static Map<String, SectionEntity> updatedSectionsMap = {};

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
    if (settingsEntity.cashInOut!.toLowerCase() == 'cashinout yes') {
      targetMap['cashInOut'] = sourceMap['cashInOut']!;
    }
    if (settingsEntity.purchases!.toLowerCase() == 'purchases yes') {
      targetMap['purchases'] = sourceMap['purchases']!;
    }
    if (settingsEntity.sales!.toLowerCase() == 'sales yes') {
      targetMap['sales'] = sourceMap['sales']!;
    }
    if (settingsEntity.costructions!.toLowerCase() == 'costructions yes') {
      targetMap['costructions'] = sourceMap['costructions']!;
    }
    if (settingsEntity.charterparty!.toLowerCase() == 'charterparty yes') {
      targetMap['charterparty'] = sourceMap['charterparty']!;
    }
    if (settingsEntity.humanResources!.toLowerCase() == 'humanResources yes') {
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
        'realStateInvestments yes') {
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

  void loadMenu() async {
    try {
      var either = await ApiManager.getInstance().fetchSettingsData();
      either.fold(
          (l) => emit(HomeScreenError(message: "Failed to load menu items")),
          (r) {
        String token = SharedPrefrence.getData(key: "accessToken") as String;
        print(token);
        updateSectionsMapBasedOnSettings(
            sourceMap: menus, targetMap: updatedSectionsMap, settingsEntity: r);

        emit(HomeScreenSuccess(menus: updatedSectionsMap, settingsEntity: r));
      });
      /*  emit(HomeScreenSuccess(menus: menus)); */
    } catch (e) {
      emit(HomeScreenError(message: "Failed to load menu items"));
    }
  }
}
