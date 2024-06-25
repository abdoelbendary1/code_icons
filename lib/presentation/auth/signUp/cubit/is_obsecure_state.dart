
import 'package:code_icons/presentation/utils/constants.dart';

class IsObsecureState {}

class HidingEye extends IsObsecureState {
  bool confirmPassIsObsecure = true;
  String passviewIcon = AppAssets.hidePass;
}

class ViewingEye extends IsObsecureState {
  String viewIcon = AppAssets.viewPass;
  bool passIsObsecure = false;
  bool confirmPassIsObsecure = false;
}
