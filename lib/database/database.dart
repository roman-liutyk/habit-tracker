import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class HabitsTable extends Table {
  late final id = integer().autoIncrement()();
  late final title = text().withLength(min: 4, max: 32)();
  late final group = integer().references(GroupsTable, #id)();
  late final createdAt = dateTime()();
}

class GroupsTable extends Table {
  late final id = integer().autoIncrement()();
  late final name = text().withLength(min: 4, max: 32)();
}

@DriftDatabase(tables: [GroupsTable, HabitsTable])
class HabitsDatabase extends _$HabitsDatabase {
  HabitsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'habits_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
