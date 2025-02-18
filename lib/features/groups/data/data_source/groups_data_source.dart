import 'package:habit_tracker/database/database.dart';

abstract class GroupsDataSource {
  Future<List<GroupsTableData>> fetchGroups();

  Future<int> addGroup({
    required String name,
  });
}

class GroupsDataSourceImpl implements GroupsDataSource {
  const GroupsDataSourceImpl({
    required HabitsDatabase db,
  }) : _db = db;

  final HabitsDatabase _db;

  @override
  Future<List<GroupsTableData>> fetchGroups() async =>
      await _db.select(_db.groupsTable).get();

  @override
  Future<int> addGroup({required String name}) async =>
      await _db.into(_db.groupsTable).insert(
            GroupsTableCompanion.insert(
              name: name,
            ),
          );
}
