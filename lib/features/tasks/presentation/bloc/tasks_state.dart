import 'package:equatable/equatable.dart';
import 'package:space_scutum/features/tasks/domain/entities/task_entity.dart';
import 'package:space_scutum/features/tasks/domain/task_status_filter.dart';

enum TasksStatus { initial, loading, success, failure }

class TasksState extends Equatable {
  const TasksState({
    required this.status,
    this.tasks = const [],
    this.availableCategories = const [],
    this.selectedCategory,
    this.filterStatus = .all,
    this.errorMessage,
  });

  final TasksStatus status;
  final List<TaskEntity> tasks;

  final List<String> availableCategories;
  final String? selectedCategory;
  final TaskStatusFilter filterStatus;

  final String? errorMessage;

  List<TaskEntity> get visibleTasks {
    return tasks.where((task) {
      final matchesCategory =
          selectedCategory == null || task.category == selectedCategory;
      final matchesStatus = switch (filterStatus) {
        .all => true,
        .active => !task.isCompleted,
        .completed => task.isCompleted,
      };
      return matchesCategory && matchesStatus;
    }).toList();
  }

  TasksState copyWith({
    TasksStatus? status,
    List<TaskEntity>? tasks,
    List<String>? availableCategories,
    String? selectedCategory,
    TaskStatusFilter? filterStatus,
    String? Function()? changeCategory,
    String? errorMessage,
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      availableCategories: availableCategories ?? this.availableCategories,
      selectedCategory: changeCategory != null
          ? changeCategory()
          : this.selectedCategory,
      filterStatus: filterStatus ?? this.filterStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    tasks,
    availableCategories,
    selectedCategory,
    filterStatus,
    errorMessage,
  ];
}
