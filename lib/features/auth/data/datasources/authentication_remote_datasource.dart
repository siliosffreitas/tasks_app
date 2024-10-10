import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exceptions.dart';
import '../models/account_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AccountModel> login(String username, String password);
}

class AuthenticationRemoteDataSourceFirebase
    implements AuthenticationRemoteDataSource {
  final FirebaseAuth firebaseInstance;

  AuthenticationRemoteDataSourceFirebase(this.firebaseInstance);
  @override
  Future<AccountModel> login(String username, String password) async {
    try {
      final result = await firebaseInstance.signInWithEmailAndPassword(
          email: username, password: password);
      return AccountModel(accessToken: result.user!.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ServerException('Usuário não encontrado');
      } else if (e.code == 'wrong-password' ||
          e.message!.contains('INVALID_LOGIN_CREDENTIALS')) {
        throw UnauthorizedException();
      } else {
        throw ServerException(e.message ?? 'Algo deu errado');
      }
    }
  }
}
