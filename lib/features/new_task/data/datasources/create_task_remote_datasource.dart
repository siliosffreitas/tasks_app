import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateTaskRemoteDataSource {
  Future<void> createTask(String title, String description);
}

class CreateTaskRemoteDataSourceFirebase implements CreateTaskRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseInstance;

  CreateTaskRemoteDataSourceFirebase(
      {required this.firestore, required this.firebaseInstance});
  @override
  Future<void> createTask(String title, String description) async {
    await firestore.collection('tasks').add({
      'title': title,
      'description': description,
      'user': firebaseInstance.currentUser!.uid,
    });
  }
}
