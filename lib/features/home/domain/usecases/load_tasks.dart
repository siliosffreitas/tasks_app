import 'package:tasks_app/features/home/domain/entities/task_entity.dart';

import '../../../../core/usecases/usecase.dart';

abstract class LoadTasks implements UseCase<List<TaskEntity>, NoParams> {}
