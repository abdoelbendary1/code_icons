import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthManagerInterface {
  Future<Either<Failures, AuthResponseDM>> login(
    String username,
    String password,
  );
  Future<void> saveUser(AuthResponseDM user);
  Future<AuthResponseDM?> getUser();
}
