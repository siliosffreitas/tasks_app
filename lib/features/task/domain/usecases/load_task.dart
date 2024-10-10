import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/entities/task_entity.dart';

abstract class LoadTask implements UseCase<TaskEntity, NoParams> {}
