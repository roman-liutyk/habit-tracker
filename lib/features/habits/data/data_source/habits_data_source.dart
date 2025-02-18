import 'package:drift/drift.dart';
import 'package:habit_tracker/database/database.dart';

abstract class HabitsDataSource {
  Future<List<HabitsTableData>> fetchHabits({
    required int groupId,
  });

  Future<int> addHabit({
    required int groupId,
    required String title,
  });

  Future<void> updateHabit({
    required int habitId,
    required bool completed,
  });

  Future<void> deleteHabit({
    required int habitId,
  });
}

class HabitsDataSourceImpl implements HabitsDataSource {
  const HabitsDataSourceImpl({
    required HabitsDatabase db,
  }) : _db = db;

  final HabitsDatabase _db;

  @override
  Future<int> addHabit({
    required int groupId,
    required String title,
  }) async {
    return await _db.into(_db.habitsTable).insert(
          HabitsTableCompanion.insert(
            title: title,
            group: groupId,
            completed: false,
            createdAt: DateTime.now(),
            lastModifiedAt: DateTime.now(),
          ),
        );
  }

  @override
  Future<void> deleteHabit({
    required int habitId,
  }) async {
    await _db.habitsTable.deleteWhere((data) => data.id.equals(habitId));
  }

  @override
  Future<List<HabitsTableData>> fetchHabits({
    required int groupId,
  }) async {
    return await (_db.select(_db.habitsTable)
          ..where((data) => data.group.equals(groupId)))
        .get();
  }

  @override
  Future<void> updateHabit({
    required int habitId,
    required bool completed,
  }) async {
    await (_db.update(_db.habitsTable)
          ..where((data) => data.id.equals(habitId)))
        .write(
      HabitsTableCompanion(
        completed: Value(completed),
        lastModifiedAt: Value(
          DateTime.now(),
        ),
      ),
    );
  }
}
