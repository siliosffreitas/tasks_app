import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel(
      {required String id, required String title, required String description})
      : super(
          id: id,
          title: title,
          description: description,
        );

  factory TaskModel.fromJson(Map json) => TaskModel(
        title: json['title'],
        description: json['description'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'id': id,
      };
}
