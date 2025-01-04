// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/api/sysSettings/ISysSetting.dart';
import 'package:code_icons/data/model/response/sysSettings/sys_settings.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

class GetSysSettingUSecase {
  ISysSettings iSysSettings;
  GetSysSettingUSecase({
    required this.iSysSettings,
  });
  Future<Either<Failures, SysSettingsDM>> getSysSettingsData() async {
    return await iSysSettings.getSysSettingsData();
  }
}
