import 'package:tasks_app/core/usecases/usecase.dart';
import 'package:tasks_app/features/home/domain/repositories/logout_repository.dart';
import 'package:tasks_app/features/home/domain/usecases/logout.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockLogoutRepository extends Mock implements LogoutRepository {}

void main() {
  late Logout usecase;
  late LogoutRepository repository;

  setUp(() {
    repository = MockLogoutRepository();
    usecase = LogoutImp(repository: repository);
  });

  test('Should call load from the repository', () async {
    when(() => repository.logout()).thenAnswer((_) async => const Right(null));

    final result = await usecase(NoParams());

    expect(result, const Right(null));
    verify(() => repository.logout()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
