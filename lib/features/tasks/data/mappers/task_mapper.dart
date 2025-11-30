import 'package:space_scutum/core/database/app_database.dart';
import 'package:space_scutum/features/tasks/domain/entities/task_entity.dart';

extension TaskToEntity on Task {
  TaskEntity toEntity() => TaskEntity(
    taskId: taskId,
    title: title,
    description: description,
    category: category,
    isCompleted: isCompleted,
  );
}

extension TaskEntityToCompanion on TaskEntity {
  TasksCompanion toInsertCompanion() {
    return TasksCompanion.insert(
      title: title,
      description: description,
      category: category,
      isCompleted: isCompleted,
    );
  }
}
