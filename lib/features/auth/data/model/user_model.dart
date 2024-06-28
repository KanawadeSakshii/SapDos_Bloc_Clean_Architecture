enum UserRole { doctor, patient }

extension UserRoleExtension on UserRole {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

//@JsonSerializable()

class UserModel {
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

  UserModel({
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'uId': uId,
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'password': password,
      'confirmpassword': confirmpassword,
      'role': role == UserRole.patient ? 'patient' : 'doctor',
      'description': description,
      'specialization': specialization,
      'address': address,
      'age': age,
      'documents': documents,
      'disease': disease,
    };
    if (role == UserRole.doctor) {
      data['experience'] = experience;
    }
    return data;
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'],
      name: map['name'],
      email: map['email'],
      mobileNumber: map['mobileNumber'],
      password: map['password'],
      confirmpassword: map['confirmpassword'],
      role: map['role'] == 'patient' ? UserRole.patient : UserRole.doctor,
      experience: map['role'] == 'doctor' ? map['experience'] : null,
      description: map['description'],
      specialization: map['specialization'],
      address: map['address'],
      age: map['age'],
      documents:
          map['documents'] != null ? List<String>.from(map['documents']) : null,
      disease: map['disease'],
    );
  }
}
