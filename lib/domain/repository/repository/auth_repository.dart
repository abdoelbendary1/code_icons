import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';


abstract class AuthRepository {

  Future<Either<Failures, AuthRepoEntity>> login(
    String username,
    String password,
  );
}
