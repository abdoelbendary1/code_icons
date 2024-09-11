import 'package:code_icons/data/interfaces/IStorageService.dart';
import 'package:hive/hive.dart';

class StorageServiceImpl implements IStorageService {
  @override
  Future<void> saveData({required String key, required String value}) async {
    var box = await Hive.openBox('storageBox');
    await box.put(key, value);
  }

  @override
  Future<String?> getData({required String key}) async {
    var box = await Hive.openBox('storageBox');
    return box.get(key);
  }
}
