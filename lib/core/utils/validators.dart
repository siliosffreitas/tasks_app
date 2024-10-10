bool isEmailValid(String email) {
  final regexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return email.isNotEmpty != true || regexp.hasMatch(email);
}

bool isPasswordValid(String password) {
  final regexp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  return password.isNotEmpty != true || regexp.hasMatch(password);
}
