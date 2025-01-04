// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  AuthRepository authRepository;
  LoginUseCase({
    required this.authRepository,
  });
  Future<Either<Failures, AuthRepoEntity>> invoke(
      String username, String password) async {
    return await authRepository.login(username, password);
  }
}
