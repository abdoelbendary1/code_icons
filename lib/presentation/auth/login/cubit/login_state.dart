// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';

abstract class LoginState {}

class LoginLoadinState extends LoginState {
  String loadingMessege = "Loading...";
}

class LoginErrorState extends LoginState {
  String? errorMessege;
  LoginErrorState({
    required this.errorMessege,
  });
}

class LoginSuccesState extends LoginState {
  AuthRepoEntity loginRepositoryEntity;
  LoginSuccesState({
    required this.loginRepositoryEntity,
  });
}
