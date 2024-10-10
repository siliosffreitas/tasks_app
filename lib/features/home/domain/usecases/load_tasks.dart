import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/load_tasks_repository.dart';

abstract class LoadTasks implements UseCase<List<TaskEntity>, NoParams> {}

class LoadTasksImp implements LoadTasks {
  final LoadTasksRepository repository;

  LoadTasksImp({required this.repository});
  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) =>
      repository.load();
}
