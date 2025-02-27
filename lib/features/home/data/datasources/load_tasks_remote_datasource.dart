import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';

abstract class LoadTasksRemoteDataSource {
  Future<List<TaskModel>> load();
}

class LoadTasksRemoteDataSourceFirebase implements LoadTasksRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseInstance;

  LoadTasksRemoteDataSourceFirebase({
    required this.firestore,
    required this.firebaseInstance,
  });
  @override
  Future<List<TaskModel>> load() async {
    final user = firebaseInstance.currentUser!.uid;
    final snapshots = await firestore
        .collection('tasks')
        .where('user', isEqualTo: user)
        .orderBy('created_at')
        .get();
    final list = snapshots.docs.map((doc) {
      final Map<String, dynamic> data = doc.data();
      data['id'] = doc.id;
      return TaskModel.fromJson(data);
    }).toList();
    return list;
  }
}
