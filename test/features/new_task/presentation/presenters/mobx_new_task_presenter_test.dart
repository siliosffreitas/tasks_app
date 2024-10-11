@Timeout(Duration(seconds: 5))
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:dartz/dartz.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/new_task/domain/usecases/create_task.dart';
import 'package:tasks_app/features/new_task/presentation/presenters/mobx_new_task_presenter.dart';

class MockCreateTask extends Mock implements CreateTask {}

void main() {
  late MobxNewTaskPresenter sut;
  late CreateTask usecase;
  late String tTitle;
  late String tDescription;

  setUpAll(() {
    tTitle = faker.lorem.sentence();
    tDescription = faker.lorem.sentence();
    registerFallbackValue(CreateTaskParams(
      title: tTitle,
      description: tDescription,
    ));
  });

  setUp(() {
    usecase = MockCreateTask();
    sut = MobxNewTaskPresenter(
      usecase: usecase,
    );

    when(() => usecase(any())).thenAnswer((_) async => const Right(null));
  });

  test(
    'Should emit corret events when validate title success',
    () {
      sut.validateTitle(tTitle);

      expect(sut.title, tTitle);
      expect(sut.titleError, '');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate title fails empty',
    () {
      sut.validateTitle('');

      expect(sut.title, '');
      expect(sut.titleError, 'Título obrigatório');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate description success',
    () {
      sut.validateDescription(tDescription);

      expect(sut.description, tDescription);
      expect(sut.descriptionError, '');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate description fails invalid',
    () {
      sut.validateDescription('');

      expect(sut.description, '');
      expect(sut.descriptionError, 'Descrição obrigatória');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit isFormValid as true if username and description have no errors',
    () {
      sut.validateTitle(tTitle);
      sut.validateDescription(tDescription);

      expect(sut.isFormValid, true);
    },
  );

  test(
    'Should call usecase with correct values',
    () async {
      sut.validateTitle(tTitle);

      sut.validateDescription(tDescription);

      await sut.createTask();

      verify(() => usecase(
              CreateTaskParams(title: tTitle, description: tDescription)))
          .called(1);
    },
  );

  test(
    'Should emit correct events on usecase invalidCredentialsError',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(UnauthorizedFailure()));
      sut.validateTitle(tTitle);
      sut.validateDescription(tDescription);

      await sut.createTask();

      expect(sut.mainError,
          'Credenciais inválidas, verifique as informações digitadas e tente novamente.');
    },
  );

  test(
    'Should emit correct events on usecase ServerFailure',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      sut.validateTitle(tTitle);
      sut.validateDescription(tDescription);

      await sut.createTask();

      expect(sut.mainError, 'Server error');
    },
  );

  test(
    'Should change page on usecase success',
    () async {
      sut.validateTitle(tTitle);
      sut.validateDescription(tDescription);

      await sut.createTask();

      expect(sut.navigateTo, '/success');
    },
  );
}
