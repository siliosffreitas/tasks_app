import '../../../home/data/models/task_model.dart';

abstract class LoadTaskRemoteDataSource {
  Future<TaskModel> load();
}
