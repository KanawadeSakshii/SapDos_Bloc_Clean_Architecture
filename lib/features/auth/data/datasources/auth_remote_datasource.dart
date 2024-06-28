// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../model/auth_login_model.dart';
// import '../model/user_register_model.dart';

// class AuthProvider {
//   final String baseUrl =
//       'https://sapdos-api-v2.azurewebsites.net/api/Credentials';

//   Future<Map<String, dynamic>> login(UserLoginModel user) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/Login'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(user.toJson()),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else if (response.statusCode == 401 || response.statusCode == 403) {
//       throw Exception('Invalid credentials');
//     } else {
//       throw Exception('Failed to login. Status code: ${response.statusCode}');
//     }
//   }

//   Future<String> register(UserRegisterModel user) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/Register'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(user.toJson()),
//     );

//     if (response.statusCode == 200) {
//       return 'Registration successful';
//     } else if (response.statusCode == 400) {
//       throw Exception('Invalid registration data');
//     } else {
//       throw Exception('Failed to register. State code: ${response.statusCode}');
//     }
//   }
// }
