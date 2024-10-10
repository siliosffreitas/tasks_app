import '../../../auth/data/models/account_model.dart';

abstract class CheckHasLoggedUserRemoteDataSource {
  Future<AccountModel?> check();
}
