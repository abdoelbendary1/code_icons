
import 'package:code_icons/presentation/auth/signUp/cubit/is_obsecure_state.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsObsecureCubit extends Cubit<IsObsecureState> {
  IsObsecureCubit() : super(HidingEye());
  bool passIsObsecure = true;
  String passViewIcon = AppAssets.hidePass;
  String confirmPassViewIcon = AppAssets.hidePass;

  bool confirmPassIsObsecure = true;

  void changeObsecurePassword() {
    if (passIsObsecure == true) {
      passIsObsecure = false;
      passViewIcon = AppAssets.viewPass;
      emit(ViewingEye());
    } else {
      passViewIcon = AppAssets.hidePass;
      passIsObsecure = true;
      emit(HidingEye());
    }
  }

  void changeObsecureConfirmPassword() {
    if (confirmPassIsObsecure == true) {
      confirmPassIsObsecure = false;
      confirmPassViewIcon = AppAssets.viewPass;
      emit(ViewingEye());
    } else {
      confirmPassViewIcon = AppAssets.hidePass;
      confirmPassIsObsecure = true;
      emit(HidingEye());
    }
  }
}
