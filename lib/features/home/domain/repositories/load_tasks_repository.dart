import 'package:dartz/dartz.dart';
import '../entities/task_entity.dart';

import '../../../../core/error/failures.dart';

abstract class LoadTasksRepository {
  Future<Either<Failure, List<TaskEntity>>> load();
}
