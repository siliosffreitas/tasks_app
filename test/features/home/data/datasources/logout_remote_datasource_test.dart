import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_app/features/home/data/datasources/logout_remote_datasource.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late LogoutRemoteDataSourceFirebase sut;
  late FirebaseAuth firebase;

  setUp(() {
    firebase = MockFirebaseAuth();
    sut = LogoutRemoteDataSourceFirebase(firebase);
    when(() => firebase.signOut()).thenAnswer((_) async => _);
  });

  test('Should call firebase logout', () async {
    await sut.logout();
    verify(() => firebase.signOut());
  });
}
