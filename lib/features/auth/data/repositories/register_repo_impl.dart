import 'dart:convert';
import 'package:bloc_project/features/auth/data/model/user_login_model.dart';
import 'package:bloc_project/features/auth/data/model/user_model.dart';
import 'package:bloc_project/features/auth/domain/repositories/userRepository.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final String baseUrl = 'https://sapdos-api-v2.azurewebsites.net/api';

  @override
  Future<bool> checkUserExists(String email) async {
    final url = Uri.parse('$baseUrl/Users/CheckUserExists?email=$email');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['exists'] ?? false;
      } else {
        throw Exception('Failed to check user existence');
      }
    } catch (e) {
      throw Exception('Failed to check user existence: $e');
    }
  }

  // @override
  // Future<Either<String, UserModel>> registerUser(UserModel user) async {
  //   final url = Uri.parse('$baseUrl/Credentials/Register');
  //   try {
  //     logger.info('About to make HTTP POST request');

  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Accept': '*/*',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(user.toJson()),
  //     );
  //     logger.info('HTTP Response Status Code: ${response.statusCode}');
  //     logger.info('HTTP Response Body: ${response.body}');
  //     if (response.statusCode == 200) {
  //       return Right(UserModel.fromJson(jsonDecode(response.body)));
  //     } else {
  //       return Left('Failed to register user: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     return Left('Failed to register user: $e');
  //   }
  // }
  @override
  Future<Either<String, UserModel>> registerUser(UserModel user) async {
    final url = Uri.parse('$baseUrl/Credentials/Register');
    try {
      logger.info('About to make HTTP POST request');

      final response = await http.post(
        url,
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );
      logger.info('HTTP Response Status Code: ${response.statusCode}');
      logger.info('HTTP Response Body: ${response.body}');
      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        return Left('Failed to register user: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Failed to register user: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> loginUser(
      UserLoginModel login) async {
    final url = Uri.parse('$baseUrl/Credentials/Login');
    try {
      logger.info('About to make HTTP POST request for login');

      final response = await http.post(
        url,
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(login.toJson()),
      );
      logger.info('HTTP Response Status Code: ${response.statusCode}');
      logger.info('HTTP Response Body: ${response.body}');
      if (response.statusCode == 200) {
        return Right(jsonDecode(response.body));
        // final Map<String, dynamic> responseData = jsonDecode(response.body);
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('token', responseData['token']);
        // await prefs.setString('user', jsonEncode(responseData['user']));

        // return Right(responseData);
      } else {
        return Left('Failed to login user: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Failed to login user: $e');
    }
  }
}