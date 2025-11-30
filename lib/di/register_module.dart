import 'package:injectable/injectable.dart';
import 'package:space_scutum/core/database/app_database.dart';
import 'package:space_scutum/core/database/daos/tasks_dao.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AppDatabase get appDatabase => AppDatabase();

  @lazySingleton
  TasksDao tasksDao(AppDatabase db) => db.tasksDao;
}
