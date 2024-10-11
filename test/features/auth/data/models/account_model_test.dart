import 'dart:convert';

import 'package:tasks_app/features/auth/data/models/account_model.dart';
import 'package:tasks_app/features/auth/domain/entities/account_entity.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late AccountModel tAccountModel;

  setUp(() {
    tAccountModel = const AccountModel(accessToken: 'siliosffreitas@gmail.com');
  });

  test('Should be a subclass of AccountEntity', () {
    expect(tAccountModel, isA<AccountEntity>());
  });

  group('fromJson', () {
    test('Should return a valid model if json is correct', () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('account.json'));

      final result = AccountModel.fromJson(jsonMap);
      expect(result, tAccountModel);
    });
  });

  group('toJson', () {
    test('Should return a valid json map containing data', () {
      final result = tAccountModel.toJson();

      expect(result, {'access_token': tAccountModel.accessToken});
    });
  });
}
