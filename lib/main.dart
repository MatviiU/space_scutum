import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_scutum/di/injection_container.dart';
import 'package:space_scutum/features/tasks/presentation/bloc/tasks_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<GoRouter>();
    return BlocProvider(
      create: (context) => getIt<TasksCubit>()..loadTasks(),
      child: MaterialApp.router(title: 'Flutter Demo', routerConfig: router),
    );
  }
}
