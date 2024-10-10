import 'package:firebase_auth/firebase_auth.dart';

import '../../../auth/data/models/account_model.dart';

abstract class CheckHasLoggedUserRemoteDataSource {
  Future<AccountModel?> check();
}

class CheckHasLoggedUserRemoteDataSourceFirebase
    implements CheckHasLoggedUserRemoteDataSource {
  final FirebaseAuth firebaseInstance;

  CheckHasLoggedUserRemoteDataSourceFirebase(this.firebaseInstance);

  @override
  Future<AccountModel?> check() async {
    final user = firebaseInstance.currentUser;
    if (user == null) {
      return null;
    }
    return AccountModel(accessToken: user.email!);
  }
}
