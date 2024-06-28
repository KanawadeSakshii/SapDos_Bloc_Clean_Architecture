extension ExtString on String {
  bool isValidEmail() {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
    return emailRegExp.hasMatch(this);
  }

  bool isValidName() {
    final nameRegExp = RegExp(r"^[A-Za-z]+(?: [A-Za-z]+)*$");
    return nameRegExp.hasMatch(this);
  }

  bool isValidPassword() {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#><*~]).{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool isValidPhone() {
    final phoneRegExp = RegExp(r'^[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }
}
