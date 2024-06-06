import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/authenticate/domain/entity/user.dart';
import 'package:bloc_project/features/authenticate/domain/repository/auth_repo.dart';
import 'package:bloc_project/features/authenticate/domain/usecases/usercase.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UserCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
