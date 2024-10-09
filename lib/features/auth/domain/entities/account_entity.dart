import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String accessToken;

  const AccountEntity({
    required this.accessToken,
  });

  @override
  List get props => [accessToken];
}
