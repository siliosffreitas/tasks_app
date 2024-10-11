import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List get props => [id, title, description];
}
