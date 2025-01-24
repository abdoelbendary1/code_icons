import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:hive/hive.dart';

class AuthUtils {
  Future<int> getUserId() async {
    var userBox = Hive.box('userBox');
    AuthRepoEntity? user = userBox.get('user');
    int userId = user!.id!;
    return userId;
  }
}
