import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  final String taskId;
  const TaskPage({required this.taskId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefa'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(taskId),
          ],
        ),
      ),
    );
  }
}
