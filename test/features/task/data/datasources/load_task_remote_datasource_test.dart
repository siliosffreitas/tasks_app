import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_app/features/task/data/datasources/load_task_remote_datasource.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {
  @override
  String get id => 'siliosilio';

  @override
  Map<String, dynamic> data() {
    return {
      'title': 'que mock grande!',
      'description': 'que mock grande, descicao!',
    };
  }
}

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
    tTaskId = faker.guid.guid();
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
}
