import 'package:bloc_project/core/error/exceptions.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/authenticate/data/datasources/auth_remote_data.dart';
import 'package:bloc_project/features/authenticate/domain/entity/user.dart';
import 'package:bloc_project/features/authenticate/domain/repository/auth_repo.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteData authRemoteData;
  AuthRepoImpl(this.authRemoteData);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteData.loginWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await authRemoteData.signUpWithEmailPassword(
          name: name, email: email, password: password),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
