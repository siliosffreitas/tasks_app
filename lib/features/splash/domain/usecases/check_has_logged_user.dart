import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/account_entity.dart';

abstract class CheckHasLoggedUser implements UseCase<AccountEntity?, NoParams> {
}
