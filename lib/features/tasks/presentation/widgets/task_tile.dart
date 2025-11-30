import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_scutum/features/tasks/domain/entities/task_entity.dart';
import 'package:space_scutum/features/tasks/presentation/bloc/tasks_cubit.dart';
import 'package:space_scutum/features/tasks/presentation/widgets/delete_task_dialog.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({required this.task, super.key});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.taskId),
      direction: .endToStart,
      background: Container(
        alignment: .centerRight,
        margin: const .symmetric(horizontal: 16, vertical: 8),
        padding: const .only(right: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFFF4B4B),
          borderRadius: .circular(24),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      confirmDismiss: (direction) {
        return _showDeleteConfirmation(context);
      },
      child: Container(
        margin: const .symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              // Тут можна відкрити екран редагування
              // Navigator.of(context).push(...)
            },
            onLongPress: () => _showDeleteConfirmation(context),
            child: Padding(
              padding: const .all(20.0),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  _CompletionCircle(
                    isCompleted: task.isCompleted,
                    onTap: () => context.read<TasksCubit>().updateTaskStatus(
                      id: task.taskId,
                      isCompleted: !task.isCompleted,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: .w600,
                            color: const Color(0xFF1A1A1A),
                            decoration: task.isCompleted ? .lineThrough : null,
                            decorationColor: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (task.description.isNotEmpty)
                          Text(
                            task.description,
                            maxLines: 2,
                            overflow: .ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8A8A8A),
                              height: 1.4,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  _CategoryChip(categoryName: task.category),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteTaskDialog(
        onConfirm: () {
          context.read<TasksCubit>().deleteTask(task.taskId);
        },
      ),
    );
  }
}

class _CompletionCircle extends StatelessWidget {
  const _CompletionCircle({required this.isCompleted, required this.onTap});

  final bool isCompleted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: .circular(20),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: .circle,
          color: isCompleted ? Colors.blue.shade400 : Colors.transparent,
          border: .all(
            color: isCompleted ? Colors.blue.shade400 : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: isCompleted
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : null,
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    if (categoryName.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const .symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: .circular(20),
      ),
      child: Text(
        categoryName,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontWeight: .w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
