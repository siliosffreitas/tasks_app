import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks_app/features/home/data/datasources/load_tasks_remote_datasource.dart';
import 'package:tasks_app/features/home/data/models/task_model.dart';
import 'package:test/test.dart';

import '../../../../mocks/firebase/mock_collection_reference.dart';
import '../../../../mocks/firebase/mock_firebase_auth.dart';
import '../../../../mocks/firebase/mock_firebase_firestore.dart';
import '../../../../mocks/firebase/mock_query.dart';
import '../../../../mocks/firebase/mock_query_document_snapshot.dart';
import '../../../../mocks/firebase/mock_query_snapshot.dart';
import '../../../../mocks/firebase/mock_user.dart';

void main() {
  late LoadTasksRemoteDataSourceFirebase sut;
  late FirebaseFirestore firestore;
  late FirebaseAuth firebase;

  late User tUser;
  late CollectionReference<Map<String, dynamic>> collection;
  late Query<Map<String, dynamic>> query;
  late QuerySnapshot<Map<String, dynamic>> querySnapshot;
  late QueryDocumentSnapshot<Map<String, dynamic>> doc;

  setUp(() {
    firestore = MockFirebaseFirestore();
    firebase = MockFirebaseAuth();
    sut = LoadTasksRemoteDataSourceFirebase(
      firestore: firestore,
      firebaseInstance: firebase,
    );
    tUser = MockUser();
    collection = MockCollectionReference();
    query = MockQuery();
    querySnapshot = MockQuerySnapshot();
    doc = MockQueryDocumentSnapshot();
    when((() => firebase.currentUser)).thenReturn(tUser);
    when((() => firestore.collection(any()))).thenReturn(collection);
    when(() => collection.where(any(), isEqualTo: any(named: 'isEqualTo')))
        .thenReturn(query);
    when(() => query.orderBy(any())).thenReturn(query);

    when(() => query.get()).thenAnswer((_) async => querySnapshot);
    when(() => querySnapshot.docs).thenReturn([doc]);
  });

  test('Should call current user from firebase', () async {
    await sut.load();
    verify(() => firebase.currentUser).called(1);
  });

  test('Should return task list', () async {
    final result = await sut.load();
    expect(result, const [
      TaskModel(
        id: 'siliosilio',
        title: 'que mock grande!',
        description: 'que mock grande, descicao!',
      )
    ]);
  });
}
