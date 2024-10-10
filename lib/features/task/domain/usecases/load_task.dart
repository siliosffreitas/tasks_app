import 'package:tasks_app/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/entities/task_entity.dart';
import '../reposirory/load_task_repository.dart';

abstract class LoadTask implements UseCase<TaskEntity, NoParams> {}

class LoadTaskImp implements LoadTask {
  final LoadTaskRepository repository;

  LoadTaskImp({
    required this.repository,
  });
  @override
  Future<Either<Failure, TaskEntity>> call(NoParams params) =>
      repository.load();
}
