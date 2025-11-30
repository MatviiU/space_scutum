class TaskEntity {
  const TaskEntity({
    required this.taskId,
    required this.title,
    required this.description,
    required this.category,
    required this.isCompleted,
  });

  final int taskId;
  final String title;
  final String description;
  final String category;
  final bool isCompleted;
}
