import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:space_scutum/features/tasks/presentation/screens/task_form_page.dart';
import 'package:space_scutum/features/tasks/presentation/screens/tasks_page.dart';
import 'package:space_scutum/router/app_routes_names.dart';

@module
abstract class AppRouterModule {
  @singleton
  GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutesNames.tasksPage,
        builder: (context, state) => const TasksPage(),
        routes: [
          GoRoute(
            path: 'task-form-page',
            name: AppRoutesNames.taskFormPage,
            builder: (context, state) => const TaskFormPage(),
          ),
        ],
      ),
    ],
  );
}
