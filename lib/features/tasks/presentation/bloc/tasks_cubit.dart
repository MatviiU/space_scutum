import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:space_scutum/features/tasks/domain/entities/task_entity.dart';
import 'package:space_scutum/features/tasks/domain/repositories/task_repository.dart';
import 'package:space_scutum/features/tasks/domain/task_status_filter.dart';
import 'package:space_scutum/features/tasks/presentation/bloc/tasks_state.dart';

@injectable
class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._tasksRepository) : super(const TasksState(status: .initial));

  final TasksRepository _tasksRepository;
  StreamSubscription<List<TaskEntity>>? _tasksSubscription;

  Future<void> loadTasks() async {
    emit(state.copyWith(status: .loading));
    try {
      await _tasksSubscription?.cancel();
      _tasksSubscription = _tasksRepository.watchAllTasks().listen(
        (tasks) {
          final categories = tasks
              .map((task) => task.category)
              .where((category) => category.isNotEmpty)
              .toSet()
              .toList();
          emit(
            state.copyWith(
              status: .success,
              tasks: tasks,
              availableCategories: categories,
            ),
          );
        },
        onError: (Object error) => emit(
          state.copyWith(status: .failure, errorMessage: error.toString()),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: .failure, errorMessage: e.toString()));
    }
  }

  Future<void> addTask(TaskEntity task) async {
    try {
      await _tasksRepository.addTask(task);
    } catch (e) {
      emit(
        state.copyWith(status: .failure, errorMessage: 'Failed to add task'),
      );
    }
  }

  Future<void> updateTaskStatus({
    required int id,
    required bool isCompleted,
  }) async {
    try {
      await _tasksRepository.updateTaskStatus(id: id, isCompleted: isCompleted);
    } catch (e) {
      emit(
        state.copyWith(status: .failure, errorMessage: 'Failed to update task'),
      );
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _tasksRepository.deleteTask(id);
    } catch (e) {
      emit(
        state.copyWith(status: .failure, errorMessage: 'Failed to delete task'),
      );
    }
  }

  void setFilterStatus(TaskStatusFilter filterStatus) {
    emit(state.copyWith(filterStatus: filterStatus));
  }

  void changeCategory(String? category) {
    emit(state.copyWith(changeCategory: () => category));
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }
}
