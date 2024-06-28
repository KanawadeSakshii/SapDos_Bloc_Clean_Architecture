import 'package:bloc_project/features/auth/data/model/user_login_model.dart';
import 'package:bloc_project/features/auth/data/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class UserRepository {
  Future<Either<String, UserModel>> registerUser(UserModel user);
  Future<Either<String, Map<String, dynamic>>> loginUser(UserLoginModel login);
  Future<bool> checkUserExists(String email);
}
