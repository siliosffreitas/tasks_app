import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/task_entity.dart';

abstract class LoadTaskRepository {
  Future<Either<Failure, TaskEntity>> load();
}
