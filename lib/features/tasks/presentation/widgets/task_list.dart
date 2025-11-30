import 'package:flutter/material.dart';
import 'package:space_scutum/features/tasks/domain/entities/task_entity.dart';
import 'package:space_scutum/features/tasks/presentation/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({required this.tasks, super.key});

  final List<TaskEntity> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(task: task);
      },
    );
  }
}
