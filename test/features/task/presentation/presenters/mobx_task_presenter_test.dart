@Timeout(Duration(seconds: 5))
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/home/domain/entities/task_entity.dart';
import 'package:tasks_app/features/home/presentation/ui/task_viewmodel.dart';
import 'package:tasks_app/features/task/domain/usecases/load_task.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:tasks_app/features/task/presentation/presenters/mobx_task_presenter.dart';

class MockLoadTask extends Mock implements LoadTask {}

void main() {
  late MobxTaskPresenter sut;
  late LoadTask usecase;
  late TaskEntity tTaskEntity;
  late TaskViewmodel tTaskModel;
  late String taskId;

  setUp(() {
    usecase = MockLoadTask();
    sut = MobxTaskPresenter(
      usecase: usecase,
    );
    taskId = faker.guid.guid();

    tTaskEntity = TaskEntity(
      id: taskId,
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
    );
    tTaskModel = TaskViewmodel(
      id: tTaskEntity.id,
      title: tTaskEntity.title,
      description: tTaskEntity.description,
    );

    when(() => usecase(any())).thenAnswer((_) async => Right(tTaskEntity));
  });

  test(
    'Should call usecase with correct values',
    () async {
      await sut.loadTask(taskId);

      verify(() => usecase(taskId)).called(1);
    },
  );

  test(
    'Should change page on usecase success',
    () async {
      await sut.loadTask(taskId);

      expect(sut.task, tTaskModel);
    },
  );

  test(
    'Should emit correct events on usecase ServerFailure',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      await sut.loadTask(taskId);

      expect(sut.mainError, 'Server error');
    },
  );

  test(
    'Should emit correct events on usecase UnauthorizedFailure',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(UnauthorizedFailure()));

      await sut.loadTask(taskId);

      expect(sut.mainError,
          'Credenciais inválidas, verifique as informações digitadas e tente novamente.');
    },
  );

  // teste adicionado apenas para que os arquivos gerados do MobX
  // TAMBÉM tenham cobertura completa
  test('Should return string', () {
    expect(sut.toString(), '''
mainError: ${sut.mainError},
isLoading: ${sut.isLoading},
navigateTo: ${sut.navigateTo},
task: ${sut.task}
    ''');
  });
}
