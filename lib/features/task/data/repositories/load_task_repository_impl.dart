import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/task_entity.dart';
import '../../domain/reposirory/load_task_repository.dart';
import '../datasources/load_task_remote_datasource.dart';

class LoadTaskRepositoryImpl implements LoadTaskRepository {
  final LoadTaskRemoteDataSource dataSource;

  LoadTaskRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, TaskEntity>> load(String taskId) async {
    try {
      final task = await dataSource.load(taskId);
      return Right(task);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }
}
