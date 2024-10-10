import 'package:firebase_auth/firebase_auth.dart';

abstract class LogoutRemoteDataSource {
  Future<void> logout();
}

class LogoutRemoteDataSourceFirebase implements LogoutRemoteDataSource {
  final FirebaseAuth firebaseInstance;

  LogoutRemoteDataSourceFirebase(this.firebaseInstance);

  @override
  Future<void> logout() async {
    await firebaseInstance.signOut();
  }
}
