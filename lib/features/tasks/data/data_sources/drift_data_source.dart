import 'package:injectable/injectable.dart';
import 'package:space_scutum/core/database/app_database.dart';
import 'package:space_scutum/core/database/daos/tasks_dao.dart';

abstract interface class DriftDataSource {
  Stream<List<Task>> watchAllTasks();

  Future<Task?> getTaskById(int id);

  Future<int> insertTask(TasksCompanion companion);

  Future<int> updateTaskStatus({required int id, required bool isCompleted});

  Future<int> deleteTask(int id);
}

@LazySingleton(as: DriftDataSource)
class DriftDataSourceImpl implements DriftDataSource {
  DriftDataSourceImpl(this._tasksDao);

  final TasksDao _tasksDao;

  @override
  Future<int> deleteTask(int id) => _tasksDao.deleteTask(id);

  @override
  Future<Task?> getTaskById(int id) => _tasksDao.getTaskById(id);

  @override
  Future<int> insertTask(TasksCompanion companion) =>
      _tasksDao.insertTask(companion);

  @override
  Future<int> updateTaskStatus({required int id, required bool isCompleted}) =>
      _tasksDao.updateTaskStatus(id: id, isCompleted: isCompleted);

  @override
  Stream<List<Task>> watchAllTasks() => _tasksDao.watchAllTasks();
}
