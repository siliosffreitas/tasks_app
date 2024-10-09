import '../../domain/entities/index.dart';

class AccountModel extends AccountEntity {
  const AccountModel({required String accessToken})
      : super(accessToken: accessToken);

  factory AccountModel.fromJson(Map json) => AccountModel(
        accessToken: json['access_token'],
      );

  Map<String, dynamic> toJson() => {'access_token': accessToken};
}
