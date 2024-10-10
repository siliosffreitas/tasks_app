import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/create_task_repository.dart';

abstract class CreateTask implements UseCase<void, CreateTaskParams> {}

class CreateTaskImp implements CreateTask {
  final CreateTaskRepository repository;

  CreateTaskImp({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(CreateTaskParams params) =>
      repository.createTask(params.title, params.description);
}

class CreateTaskParams extends Equatable {
  final String title;
  final String description;

  const CreateTaskParams({
    required this.title,
    required this.description,
  });

  @override
  List get props => [title, description];
}
