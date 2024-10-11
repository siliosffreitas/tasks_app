import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';

abstract class LoadTasksRepository {
  Future<Either<Failure, List<TaskEntity>>> load();
}
