import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exceptions.dart';

import '../../../auth/data/models/account_model.dart';

abstract class AddAccountRemoteDataSource {
  Future<AccountModel> signin(String username, String password);
}

class AddAccountRemoteDataSourceFirebase implements AddAccountRemoteDataSource {
  final FirebaseAuth firebaseInstance;

  AddAccountRemoteDataSourceFirebase(this.firebaseInstance);
  @override
  Future<AccountModel> signin(String username, String password) async {
    try {
      final result = await firebaseInstance.createUserWithEmailAndPassword(
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
