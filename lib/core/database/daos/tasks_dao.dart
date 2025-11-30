import 'package:drift/drift.dart';
import 'package:space_scutum/core/database/app_database.dart';
import 'package:space_scutum/core/database/tables/tasks_table.dart';

part 'tasks_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(super.db);

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future<Task?> getTaskById(int id) =>
      (select(tasks)..where((tbl) => tbl.taskId.equals(id))).getSingleOrNull();

  Future<int> insertTask(TasksCompanion companion) =>
      into(tasks).insert(companion);

  Future<int> updateTaskStatus({required int id, required bool isCompleted}) =>
      (update(tasks)..where((tbl) => tbl.taskId.equals(id))).write(
        TasksCompanion(isCompleted: Value(isCompleted)),
      );

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((tbl) => tbl.taskId.equals(id))).go();
}
