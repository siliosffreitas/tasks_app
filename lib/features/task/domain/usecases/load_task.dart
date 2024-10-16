import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/entities/task_entity.dart';
import '../reposirory/load_task_repository.dart';

abstract class LoadTask implements UseCase<TaskEntity, String> {}

class LoadTaskImp implements LoadTask {
  final LoadTaskRepository repository;

  LoadTaskImp({
    required this.repository,
  });
  @override
  Future<Either<Failure, TaskEntity>> call(String taskId) =>
      repository.load(taskId);
}
