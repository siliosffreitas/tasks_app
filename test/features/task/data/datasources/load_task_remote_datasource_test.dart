import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_app/features/home/data/models/task_model.dart';
import 'package:tasks_app/features/task/data/datasources/load_task_remote_datasource.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/firebase/mock_collection_reference.dart';
import '../../../../mocks/firebase/mock_document_reference.dart';
import '../../../../mocks/firebase/mock_document_snapshot.dart';
import '../../../../mocks/firebase/mock_firebase_firestore.dart';

void main() {
  late LoadTaskRemoteDataSourceFirebase sut;
  late FirebaseFirestore firestore;

  late String tTaskId;
  late CollectionReference<Map<String, dynamic>> collection;
  late DocumentReference<Map<String, dynamic>> doc;
  late DocumentSnapshot<Map<String, dynamic>> docSnap;

  setUp(() {
    firestore = MockFirebaseFirestore();
    sut = LoadTaskRemoteDataSourceFirebase(
      firestore: firestore,
    );
    tTaskId = 'siliosilio';
    collection = MockCollectionReference();
    doc = MockDocumentReference();
    docSnap = MockDocumentSnapshot();

    when((() => firestore.collection(any()))).thenReturn(collection);
    when(() => collection.doc(any())).thenReturn(doc);
    when(() => doc.get()).thenAnswer((_) async => docSnap);
  });

  test('Should call current user from firebase', () async {
    await sut.load(tTaskId);
    verify(() => firestore.collection('tasks')).called(1);
  });

  test('Should return a task', () async {
    final result = await sut.load(tTaskId);
    expect(
        result,
        const TaskModel(
          id: 'siliosilio',
          title: 'que mock grande!',
          description: 'que mock grande, descicao!',
        ));
  });
}
