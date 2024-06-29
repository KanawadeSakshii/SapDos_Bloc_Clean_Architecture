import 'package:bloc_project/features/auth/data/model/user_model.dart';

class UserEntity {
  final String? uId;
  final String name;
  final String email;
  final String mobileNumber;
  final String password;
  final String? confirmpassword;
  final UserRole role;
  final int? experience;
  final String? specialization;
  final String? description;
  final String? address;
  final String? age;
  final String? disease;

  final List<String>? documents;

  UserEntity({
    this.uId,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.password,
    this.confirmpassword,
    required this.role,
    this.experience,
    this.specialization,
    this.description,
    this.address,
    this.age,
    this.documents,
    this.disease,
  });
}
