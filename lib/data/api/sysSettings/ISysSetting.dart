import 'package:code_icons/data/model/response/sysSettings/sys_settings.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/settings/StForm/st_form_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ISysSettings {
  Future<Either<Failures, SysSettingsDM>> getSysSettingsData();
  Future<Either<Failures, List<StFormEntity>>> getStFormData();
}
