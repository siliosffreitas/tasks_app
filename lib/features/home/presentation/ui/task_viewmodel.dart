import 'package:equatable/equatable.dart';

class TaskViewmodel extends Equatable {
  final String title;
  final String description;
  final String id;

  const TaskViewmodel({
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  List get props => [id, title, description];
}
