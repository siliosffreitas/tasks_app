import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure() : super('Erro ao salvar dados no seu dispositivo');
}

class ConnectionFailure extends Failure {
  const ConnectionFailure() : super('Sem conexão, verifique sua internet');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure()
      : super(
            'Credenciais inválidas, verifique as informações digitadas e tente novamente.');
}
