abstract class LoginPresenter {
  Stream<String?> get usernameErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<String?> get mainErrorStream;
  Stream<String?> get navigateToStream;

  void validateUserName(String userName);
  void validatePassword(String password);

  Future<void> auth();
}
