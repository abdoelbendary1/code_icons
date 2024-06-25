
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';

abstract class SignUpState {}

class SignInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {
  String loadingMessege = "Loading...";
}

class SignUpSuccessState extends SignUpState {
  AuthRepoEntity? signUpRepositoryEntitiy;
  SignUpSuccessState({
    required this.signUpRepositoryEntitiy,
  });
}

class SignUpErrorState extends SignUpState {
  String? errorMessege;
  SignUpErrorState({
    required this.errorMessege,
  });
}
