import 'package:dartz/dartz.dart';
import 'package:tasks_app/features/home/domain/entities/task_entity.dart';

import '../../../../core/error/failures.dart';

abstract class LoadTasksRepository {
  Future<Either<Failure, List<TaskEntity>>> load();
}
