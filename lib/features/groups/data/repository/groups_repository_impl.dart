import 'package:habit_tracker/database/database.dart';
import 'package:habit_tracker/features/groups/data/data_source/groups_data_source.dart';
import 'package:habit_tracker/features/groups/domain/entity/group_entity.dart';
import 'package:habit_tracker/features/groups/domain/repository/groups_repository.dart';

class GroupsRepositoryImpl implements GroupsRepository {
  const GroupsRepositoryImpl({
    required GroupsDataSource groupsDataSource,
  }) : _groupsDataSource = groupsDataSource;

  final GroupsDataSource _groupsDataSource;

  @override
  Future<int> addGroup({required String name}) async =>
      await _groupsDataSource.addGroup(name: name);

  @override
  Future<List<GroupEntity>> fetchGroups() async {
    final List<GroupsTableData> groupsData =
        await _groupsDataSource.fetchGroups();

    return groupsData.map(GroupEntity.fromDTO).toList();
  }
}
