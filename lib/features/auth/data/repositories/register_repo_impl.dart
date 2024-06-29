import 'package:bloc_project/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bloc_project/features/auth/data/model/user_login_model.dart';
import 'package:bloc_project/features/auth/data/model/user_model.dart';
import 'package:bloc_project/features/auth/domain/repositories/userRepository.dart';
import 'package:fpdart/fpdart.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> checkUserExists(String email) async {
    return await remoteDataSource.checkUserExists(email);
  }

  @override
  Future<Either<String, UserModel>> registerUser(UserModel user) async {
    return await remoteDataSource.registerUser(user);
  }

  @override
  Future<Either<String, Map<String, dynamic>>> loginUser(
      UserLoginModel login) async {
    return await remoteDataSource.loginUser(login);
  }
}
