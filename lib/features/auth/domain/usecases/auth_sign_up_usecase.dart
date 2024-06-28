import 'package:bloc_project/features/auth/data/model/user_model.dart';
import 'package:bloc_project/features/auth/domain/repositories/userRepository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUseCase {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<String, UserModel>> registerUser(UserModel user) async {
    return repository.registerUser(user).then((result) {
      return result.fold(
        (failureMessage) => Left(failureMessage),
        (userModel) => Right(userModel),
      );
    });
  }
}
