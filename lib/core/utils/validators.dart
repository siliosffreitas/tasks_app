bool isEmailValid(String email) {
  final regexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return email.isNotEmpty != true || regexp.hasMatch(email);
}
