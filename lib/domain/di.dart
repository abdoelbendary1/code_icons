//todo viewModel => Usecase
// usecas => repo
// repo => datasource
// data source => api



import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/repository/dataSource/auth_remote_data_source_impl.dart';
import 'package:code_icons/data/repository/repository/auth_repository_impl.dart';
import 'package:code_icons/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:code_icons/domain/repository/repository/auth_repository.dart';
import 'package:code_icons/domain/use_cases/login_useCase.dart';
import 'package:code_icons/domain/use_cases/signup_usecase.dart';

SignUpUseCase injectSignUpUseCase() {
  return SignUpUseCase(authRepository: injectAuthRepository());
}

LoginUseCase injectLoginUseCase() {
  return LoginUseCase(authRepository: injectAuthRepository());
}

AuthRepository injectAuthRepository() {
  return AuthRepositoryImpl(authRemoteDataSource: injectAuthDataSource());
}

AuthRemoteDataSource injectAuthDataSource() {
  return AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}


