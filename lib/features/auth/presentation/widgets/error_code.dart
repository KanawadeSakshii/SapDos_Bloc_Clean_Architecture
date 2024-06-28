import 'package:bloc_project/features/auth/data/model/user_model.dart';

enum AuthErrorCode {
  invalidEmail,
  invalidPassword,
  loginError,
  registrationError,
  dataFetchError,
}

String userRoleToString(UserRole role) {
  switch (role) {
    case UserRole.doctor:
      return 'doctor';
    case UserRole.patient:
      return 'patient';
    default:
      return '';
  }
}

UserRole stringToUserRole(String role) {
  switch (role) {
    case 'doctor':
      return UserRole.doctor;
    case 'patient':
      return UserRole.patient;
    default:
      return UserRole.doctor;
  }
}
