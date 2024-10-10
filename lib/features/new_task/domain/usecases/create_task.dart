import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';

abstract class CreateTask implements UseCase<void, CreateTaskParams> {}

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
