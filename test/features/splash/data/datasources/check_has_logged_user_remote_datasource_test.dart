import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks_app/features/auth/data/models/account_model.dart';
import 'package:tasks_app/features/splash/data/datasources/check_has_logged_user_remote_datasource.dart';
import 'package:test/test.dart';

import '../../../../mocks/firebase/mock_firebase_auth.dart';
import '../../../../mocks/firebase/mock_user.dart';

void main() {
  late CheckHasLoggedUserRemoteDataSourceFirebase sut;
  late FirebaseAuth firebase;
  late MockUser tUser;

  setUp(() {
    firebase = MockFirebaseAuth();
    sut = CheckHasLoggedUserRemoteDataSourceFirebase(firebase);
    tUser = MockUser();
  });

  test('Should call firebase currentuser ', () async {
    await sut.check();
    verify(() => firebase.currentUser).called(1);
  });

  test('Should return null if firebase currentuser is null', () async {
    when(() => firebase.currentUser).thenReturn(null);
    final result = await sut.check();
    expect(result, isNull);
  });

  test('Should return account if firebase currentuser is not null', () async {
    when(() => firebase.currentUser).thenReturn(tUser);
    final result = await sut.check();
    expect(result, const AccountModel(accessToken: 'siliosffreitas@gmail.com'));
  });
}
