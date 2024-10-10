import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../home/data/models/task_model.dart';

abstract class LoadTaskRemoteDataSource {
  Future<TaskModel> load(String taskId);
}

class LoadTaskRemoteDataSourceFirebase implements LoadTaskRemoteDataSource {
  final FirebaseFirestore firestore;

  LoadTaskRemoteDataSourceFirebase({
    required this.firestore,
  });

  @override
  Future<TaskModel> load(String taskId) async {
    final snapshot = await firestore.collection('tasks').doc(taskId).get();
    final Map<String, dynamic> data = snapshot.data()!;
    data['id'] = taskId;
    return TaskModel.fromJson(data);
  }
}
