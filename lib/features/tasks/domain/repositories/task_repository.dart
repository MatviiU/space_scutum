import 'package:injectable/injectable.dart';
import 'package:space_scutum/features/tasks/data/data_sources/drift_data_source.dart';
import 'package:space_scutum/features/tasks/data/mappers/task_mapper.dart';
import 'package:space_scutum/features/tasks/domain/entities/task_entity.dart';

abstract interface class TasksRepository {
  Stream<List<TaskEntity>> watchAllTasks();

  Future<TaskEntity?> getTaskById(int id);

  Future<int> addTask(TaskEntity entity);

  Future<int> updateTaskStatus({required int id, required bool isCompleted});

  Future<int> deleteTask(int id);
}

@LazySingleton(as: TasksRepository)
class TaskRepositoryDriftImpl implements TasksRepository {
  TaskRepositoryDriftImpl(this._driftDataSource);

  final DriftDataSource _driftDataSource;

  @override
  Future<int> deleteTask(int id) => _driftDataSource.deleteTask(id);

  @override
  Future<TaskEntity?> getTaskById(int id) async {
    final task = await _driftDataSource.getTaskById(id);
    return task?.toEntity();
  }

  @override
  Future<int> addTask(TaskEntity entity) =>
      _driftDataSource.insertTask(entity.toInsertCompanion());

  @override
  Future<int> updateTaskStatus({required int id, required bool isCompleted}) =>
      _driftDataSource.updateTaskStatus(id: id, isCompleted: isCompleted);

  @override
  Stream<List<TaskEntity>> watchAllTasks() => _driftDataSource
      .watchAllTasks()
      .map((tasks) => tasks.map((e) => e.toEntity()).toList());
}
