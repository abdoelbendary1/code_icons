// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';



class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;
  AuthRemoteDataSourceImpl({
    required this.apiManager,
  });
  @override
  Future<Either<Failures, AuthRepoEntity>> signUp(String name, String email,
      String password, String rePassword, String phone) async {
    var either =
        await apiManager.signUp(name, email, password, rePassword, phone);
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return right(response);
    });
  }

  @override
  Future<Either<Failures, AuthRepoEntity>> login(
      String email, String password) async {
    var either = await apiManager.login(email, password);
    return either.fold((failure) {
      return Left(failure);
    }, (response) {
      return right(response);
    });
  }
}
