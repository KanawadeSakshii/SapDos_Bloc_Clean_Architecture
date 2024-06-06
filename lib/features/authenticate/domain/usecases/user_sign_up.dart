import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/authenticate/domain/usecases/usercase.dart';
import 'package:bloc_project/features/authenticate/domain/entity/user.dart';
import 'package:bloc_project/features/authenticate/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UserCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
