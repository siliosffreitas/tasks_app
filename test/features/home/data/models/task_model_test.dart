import 'dart:convert';

import 'package:tasks_app/features/home/data/models/task_model.dart';
import 'package:tasks_app/features/home/domain/entities/task_entity.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late TaskModel tTaskModel;

  setUp(() {
    tTaskModel = TaskModel(
        id: 'abs:123',
        title: 'Finalizar este desafio',
        description: 'Logo logo');
  });

  test('Should be a subclass of TaskEntity', () {
    expect(tTaskModel, isA<TaskEntity>());
  });

  test('Should return a valid model if json is correct', () {
    final Map<String, dynamic> jsonMap = json.decode(fixture('task.json'));

    final result = TaskModel.fromJson(jsonMap);
    expect(result, tTaskModel);
  });

  test('Should return a valid json map containing data', () {
    final result = tTaskModel.toJson();

    expect(result, {
      'id': tTaskModel.id,
      'title': tTaskModel.title,
      'description': tTaskModel.description,
    });
  });
}
