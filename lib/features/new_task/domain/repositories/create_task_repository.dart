import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class CreateTaskRepository {
  Future<Either<Failure, void>> createTask(String title, String description);
}
