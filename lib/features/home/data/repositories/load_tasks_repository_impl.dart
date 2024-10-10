import 'package:tasks_app/features/home/domain/entities/task_entity.dart';

import 'package:tasks_app/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/load_tasks_repository.dart';
import '../datasources/load_tasks_remote_datasource.dart';

class LoadTasksRepositoryImpl implements LoadTasksRepository {
  final LoadTasksRemoteDataSource dataSource;

  LoadTasksRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, List<TaskEntity>>> load() async {
    try {
      final tasklist = await dataSource.load();
      return Right(tasklist);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }
}
