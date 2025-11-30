import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_scutum/features/tasks/presentation/bloc/tasks_cubit.dart';
import 'package:space_scutum/features/tasks/presentation/bloc/tasks_state.dart';

class TasksFilterBar extends StatelessWidget {
  const TasksFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      buildWhen: (previous, current) =>
          previous.filterStatus != current.filterStatus ||
          previous.selectedCategory != current.selectedCategory ||
          previous.availableCategories != current.availableCategories,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            SingleChildScrollView(
              scrollDirection: .horizontal,
              padding: const .symmetric(horizontal: 16),
              child: Row(
                spacing: 8,
                children: [
                  _FilterChip(
                    isSelected: state.filterStatus == .all,
                    label: 'All Tasks',
                    onTap: () =>
                        context.read<TasksCubit>().setFilterStatus(.all),
                  ),
                  _FilterChip(
                    isSelected: state.filterStatus == .active,
                    label: 'Active',
                    onTap: () =>
                        context.read<TasksCubit>().setFilterStatus(.active),
                  ),
                  _FilterChip(
                    isSelected: state.filterStatus == .completed,
                    label: 'Completed',
                    onTap: () =>
                        context.read<TasksCubit>().setFilterStatus(.completed),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const .symmetric(horizontal: 16),
                scrollDirection: .horizontal,
                itemCount: state.availableCategories.length + 1,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _FilterChip(
                      label: 'All Categories',
                      isSelected: state.selectedCategory == null,
                      onTap: () =>
                          context.read<TasksCubit>().changeCategory(null),
                    );
                  }
                  final category = state.availableCategories[index - 1];
                  return _FilterChip(
                    isSelected: category == state.selectedCategory,
                    label: category,
                    onTap: () =>
                        context.read<TasksCubit>().changeCategory(category),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.isSelected,
    required this.label,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: .circular(20),
          child: Container(
            padding: const .symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2E88EF) : Colors.white,
              borderRadius: .circular(20),
              border: .all(
                color: isSelected ? Colors.transparent : Colors.grey.shade300,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
                fontWeight: .w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
