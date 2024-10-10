import '../models/task_model.dart';

abstract class LoadTasksRemoteDataSource {
  Future<List<TaskModel>> load();
}
