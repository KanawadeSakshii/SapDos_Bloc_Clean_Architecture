class User {
  int id;
  String username;
  String password;
  String email;
  String phoneNumber;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'phone_number': phoneNumber,
    };
  }
}

// Example function to convert a list of JSON users to a list of User objects
List<User> parseUsers(List<dynamic> jsonList) {
  return jsonList.map((json) => User.fromJson(json)).toList();
}

// Example function to convert a list of User objects to a JSON list
List<Map<String, dynamic>> usersToJson(List<User> users) {
  return users.map((user) => user.toJson()).toList();
}
