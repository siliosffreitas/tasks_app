import 'package:tasks_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tasks_app/features/home/domain/entities/task_entity.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/load_tasks_repository.dart';

abstract class LoadTasks implements UseCase<List<TaskEntity>, NoParams> {}

class LoadTasksImp implements LoadTasks {
  final LoadTasksRepository repository;

  LoadTasksImp({required this.repository});
  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) =>
      repository.load();
}
