import 'package:tasks_app/features/home/domain/entities/task_entity.dart';

import 'package:tasks_app/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/reposirory/load_task_repository.dart';
import '../datasources/load_task_remote_datasource.dart';

class LoadTaskRepositoryImpl implements LoadTaskRepository {
  final LoadTaskRemoteDataSource dataSource;

  LoadTaskRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, TaskEntity>> load() async {
    try {
      final task = await dataSource.load();
      return Right(task);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }
}
