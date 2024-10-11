import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks_app/features/home/data/datasources/load_tasks_remote_datasource.dart';
import 'package:test/test.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {
  @override
  String get id => 'siliosilio';

  @override
  Map<String, dynamic> data() {
    return {
      'title': 'que mock grande!',
      'description': 'que mock grande!',
    };
  }
}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockUser extends Mock implements User {
  @override
  String get uid => 'siliosiliosilio';
}

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
    when(() => collection.orderBy(any())).thenReturn(query);

    when(() => query.get()).thenAnswer((_) async => querySnapshot);
    when(() => querySnapshot.docs).thenReturn([doc]);
  });

  test('Should call current user from firebase', () async {
    await sut.load();
    verify(() => firebase.currentUser).called(1);
  });
}
