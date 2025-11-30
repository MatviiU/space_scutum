import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:space_scutum/core/database/app_database.dart';
import 'package:space_scutum/core/database/daos/tasks_dao.dart';
import 'package:space_scutum/core/network/weather_api.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AppDatabase get appDatabase => AppDatabase();

  @lazySingleton
  TasksDao tasksDao(AppDatabase db) => db.tasksDao;

  @lazySingleton
  Dio get dio =>
      Dio(BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5'));

  @lazySingleton
  WeatherApi weatherApi(Dio dio) => WeatherApi(dio);
}
