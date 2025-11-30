import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get taskId => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  TextColumn get category => text()();

  BoolColumn get isCompleted => boolean()();
}
