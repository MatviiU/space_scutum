import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_scutum/features/tasks/presentation/bloc/tasks_cubit.dart';
import 'package:space_scutum/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:space_scutum/features/tasks/presentation/widgets/empty_tasks_widget.dart';
import 'package:space_scutum/features/tasks/presentation/widgets/task_list.dart';
import 'package:space_scutum/features/tasks/presentation/widgets/tasks_filter_bar.dart';
import 'package:space_scutum/features/weather/presentation/widgets/current_weather_widget.dart';
import 'package:space_scutum/router/app_routes_names.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        final hasTasks = state.visibleTasks.isNotEmpty;
        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFB),
          appBar: AppBar(
            title: const Text('My Tasks', style: TextStyle(fontWeight: .bold)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: hasTasks
                ? [
                    Padding(
                      padding: const .only(right: 16),
                      child: ElevatedButton(
                        onPressed: () =>
                            context.goNamed(AppRoutesNames.taskFormPage),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const .all(12),
                          backgroundColor: const Color(0xFF2E88EF),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(40, 40),
                        ),
                        child: const Icon(Icons.add, size: 24),
                      ),
                    ),
                  ]
                : null,
          ),
          body: Column(
            children: [
              const SizedBox(height: 8),
              const CurrentWeatherWidget(),
              const SizedBox(height: 16),
              const TasksFilterBar(),
              const SizedBox(height: 16),
              Expanded(
                child: hasTasks
                    ? TaskList(tasks: state.visibleTasks)
                    : const EmptyTasksWidget(),
              ),
            ],
          ),
          floatingActionButton: !hasTasks
              ? FloatingActionButton.extended(
                  onPressed: () => context.goNamed(AppRoutesNames.taskFormPage),
                  backgroundColor: const Color(0xFF2E88EF),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.add),
                  elevation: 4,
                  label: const Text('Create New Task'),
                )
              : null,
          floatingActionButtonLocation: .centerFloat,
        );
      },
    );
  }
}
