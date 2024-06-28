import 'package:bloc_project/features/auth/data/model/user_login_model.dart';
import 'package:bloc_project/features/auth/domain/repositories/userRepository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, Map<String, dynamic>>> loginUser(
      UserLoginModel login) async {
    return repository.loginUser(login);
  }
}
