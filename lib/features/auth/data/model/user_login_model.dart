class UserLoginModel {
  final String userName;
  final String password;

  UserLoginModel({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }

  factory UserLoginModel.fromJson(Map<String, dynamic> map) {
    return UserLoginModel(
      userName: map['userName'],
      password: map['password'],
    );
  }
}
