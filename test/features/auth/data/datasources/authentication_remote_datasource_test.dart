import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:mocktail/mocktail.dart';
import 'package:tasks_app/core/error/exceptions.dart';

import 'package:tasks_app/features/auth/data/datasources/authentication_remote_datasource.dart';
import 'package:tasks_app/features/auth/data/models/account_model.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../mocks/firebase/mock_firebase_auth.dart';
import '../../../../mocks/firebase/mock_user_credentials.dart';

void main() {
  late AuthenticationRemoteDataSourceFirebase datasource;
  late FirebaseAuth firebase;
  late String tUsername;
  late String tPassword;
  late AccountModel tAccountModel;
  late UserCredential tCredential;

  setUp(() {
    firebase = MockFirebaseAuth();
    tCredential = MockUserCredential();
    datasource = AuthenticationRemoteDataSourceFirebase(firebase);
    tUsername = 'siliosffreitas@gmail.com';
    tPassword = faker.internet.password();
    tAccountModel = AccountModel.fromJson(json.decode(fixture('account.json')));

    when(() => firebase.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'))).thenAnswer((_) async => tCredential);
  });

  test('Should call httpClient post and return an account', () async {
    final account = await datasource.login(tUsername, tPassword);

    verify(() => firebase.signInWithEmailAndPassword(
        email: tUsername, password: tPassword)).called(1);

    expect(account, tAccountModel);
  });

  test('Should throw UnauthorizedException if returns wrong-password',
      () async {
    when(() => firebase.signInWithEmailAndPassword(
            email: any(named: 'email'), password: any(named: 'password')))
        .thenThrow(FirebaseAuthException(
            code: 'wrong-password', message: 'INVALID_LOGIN_CREDENTIALS'));

    final call = datasource.login(tUsername, tPassword);

    expect(call, throwsA(const TypeMatcher<UnauthorizedException>()));
  });

  test('Should throw ServerException if returns user-not-found', () async {
    when(() => firebase.signInWithEmailAndPassword(
            email: any(named: 'email'), password: any(named: 'password')))
        .thenThrow(FirebaseAuthException(code: 'user-not-found'));

    final call = datasource.login(tUsername, tPassword);

    expect(call, throwsA(const TypeMatcher<ServerException>()));
  });

  test('Should throw ServerException if returns any error', () async {
    when(() => firebase.signInWithEmailAndPassword(
            email: any(named: 'email'), password: any(named: 'password')))
        .thenThrow(FirebaseAuthException(code: 'any-other-error', message: ''));

    final call = datasource.login(tUsername, tPassword);

    expect(call, throwsA(const TypeMatcher<ServerException>()));
  });

  test('Should throw ServerException if http throws', () async {
    when(() => firebase.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'))).thenThrow(Exception());

    final call = datasource.login(tUsername, tPassword);

    expect(call, throwsA(const TypeMatcher<ServerException>()));
  });
}
