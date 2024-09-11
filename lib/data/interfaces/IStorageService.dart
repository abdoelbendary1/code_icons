abstract class IStorageService {
  Future<void> saveData({required String key, required String value});
  Future<String?> getData({required String key});
}
