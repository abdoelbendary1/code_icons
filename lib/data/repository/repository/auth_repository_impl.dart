// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:code_icons/domain/repository/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failures, AuthRepoEntity>> login(
      String username, String password) {
    return authRemoteDataSource.login(username, password);
  }
}
