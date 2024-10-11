@Timeout(Duration(seconds: 5))
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/core/usecases/usecase.dart';
import 'package:tasks_app/features/home/domain/entities/task_entity.dart';
import 'package:tasks_app/features/home/domain/usecases/load_tasks.dart';
import 'package:tasks_app/features/home/domain/usecases/logout.dart';
import 'package:tasks_app/features/home/presentation/presenters/mobx_home_presenter.dart';
import 'package:tasks_app/features/home/presentation/ui/task_viewmodel.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:dartz/dartz.dart';

class MockLoadTasks extends Mock implements LoadTasks {}

class MockLogout extends Mock implements Logout {}

void main() {
  late MobxHomePresenter sut;
  late LoadTasks loadTasksUsecase;
  late Logout logoutUsecase;

  late List<TaskEntity> tasks;
  late List<TaskViewmodel> tasksVM;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    loadTasksUsecase = MockLoadTasks();
    logoutUsecase = MockLogout();
    sut = MobxHomePresenter(
      loadTasksUsecase: loadTasksUsecase,
      logoutUsecase: logoutUsecase,
    );

    tasks = [
      TaskEntity(
        id: faker.guid.guid(),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
      TaskEntity(
        id: faker.guid.guid(),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
    ];
    tasksVM = tasks
        .map((tTaskEntity) => TaskViewmodel(
              id: tTaskEntity.id,
              title: tTaskEntity.title,
              description: tTaskEntity.description,
            ))
        .toList();

    when(() => loadTasksUsecase(any())).thenAnswer((_) async => Right(tasks));
    when(() => logoutUsecase(any())).thenAnswer((_) async => const Right(null));
  });

  test(
    'Should call usecase with correct values',
    () async {
      await sut.loadTasks();

      verify(() => loadTasksUsecase(NoParams())).called(1);
    },
  );

  test(
    'Should change page on usecase success',
    () async {
      await sut.loadTasks();

      expect(sut.tasks, tasksVM);
    },
  );

  test(
    'Should emit correct events on usecase ServerFailure',
    () async {
      when(() => loadTasksUsecase(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      await sut.loadTasks();

      expect(sut.mainError, 'Server error');
    },
  );

  test(
    'Should emit correct events on usecase UnauthorizedFailure',
    () async {
      when(() => loadTasksUsecase(any()))
          .thenAnswer((_) async => const Left(UnauthorizedFailure()));

      await sut.loadTasks();

      expect(sut.mainError,
          'Credenciais inválidas, verifique as informações digitadas e tente novamente.');
    },
  );

  test('Should go to new task page', () {
    sut.goToNewTaskPage();

    expect(sut.navigateTo, '/new_task');
  });

  test('Should go to task page', () {
    sut.goToTaskPage('123');

    expect(sut.navigateTo, '/task/123');
  });

  test('Should show logout confirmation', () {
    sut.showConfirmationLogout();

    expect(sut.navigateTo, '/confirmation_logout');
  });

  test('Should show logout page if logout succeeds', () async {
    await sut.logout();

    expect(sut.navigateTo, '/login');
  });

  test('Should show logout page if logout fails', () async {
    when(() => logoutUsecase(any()))
        .thenAnswer((_) async => const Left(CacheFailure()));
    await sut.logout();

    expect(sut.navigateTo, '/login');
  });

// teste adicionado apenas para que os arquivos gerados do MobX
// TAMBÉM tenham cobertura completa
  test('Should return string', () {
    expect(sut.toString(), '''
mainError: ${sut.mainError},
isLoading: ${sut.isLoading},
navigateTo: ${sut.navigateTo},
tasks: ${sut.tasks}
    ''');
  });
}
