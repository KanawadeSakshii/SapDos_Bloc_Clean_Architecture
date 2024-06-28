class UserData {
  //final String? token;
  final String uId;
  final String role;

  UserData({
    required this.uId,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      //    token: json['token'] as String?,
      uId: json['uId'],
      role: json['role'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      //   'token': token,
      'uId': uId,
      'role': role,
    };
  }
}
