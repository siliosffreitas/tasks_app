import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';

import '../models/account_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AccountModel> login(String username, String password);
}

class AuthenticationRemoteDataSourceImp
    implements AuthenticationRemoteDataSource {
  final Client httpClient;

  AuthenticationRemoteDataSourceImp(this.httpClient);
  @override
  Future<AccountModel> login(String username, String password) async {
    try {
      final response = await httpClient.post(
        Uri.parse(
            'https://277eaaa5-0186-48d5-b67a-0eba7372f8ed.mock.pstmn.io/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return AccountModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException('${response.statusCode}');
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (_) {
      throw ServerException('Anything is wrong');
    }
  }
}
