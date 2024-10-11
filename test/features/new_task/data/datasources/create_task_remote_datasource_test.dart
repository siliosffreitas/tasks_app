import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mocktail/mocktail.dart';

import 'package:tasks_app/features/new_task/data/datasources/create_task_remote_datasource.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';

import '../../../../mocks/firebase/mock_collection_reference.dart';
import '../../../../mocks/firebase/mock_document_reference.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  User? get currentUser => MockUser();
}

class MockUser extends Mock implements User {
  @override
  String? get email => 'siliosffreitas@gmail.com';

  @override
  String get uid => 'abc:123';
}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late CreateTaskRemoteDataSourceFirebase datasource;
  late FirebaseAuth firebase;
  late FirebaseFirestore storage;
  late String tTitle;
  late String tDescription;
  late CollectionReference<Map<String, dynamic>> collection;
  late DocumentReference<Map<String, dynamic>> reference;

  setUp(() {
    firebase = MockFirebaseAuth();
    storage = MockFirebaseFirestore();
    collection = MockCollectionReference();
    reference = MockDocumentReference();
    datasource = CreateTaskRemoteDataSourceFirebase(
        firestore: storage, firebaseInstance: firebase);
    tTitle = faker.lorem.sentence();
    tDescription = faker.lorem.sentence();

    when(() => storage.collection(any())).thenReturn(collection);
    when(() => collection.add(any())).thenAnswer((_) async => reference);
  });

  test('Should call httpClient post and return an account', () async {
    await datasource.createTask(tTitle, tDescription);

    verify(() => storage.collection('tasks').add({
          'title': tTitle,
          'description': tDescription,
          'user': 'abc:123',
          'created_at': DateTime.now()
        })).called(1);
  });
}
