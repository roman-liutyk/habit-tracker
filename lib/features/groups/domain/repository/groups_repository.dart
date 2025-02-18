import 'package:habit_tracker/features/groups/domain/entity/group_entity.dart';

abstract class GroupsRepository {
  Future<List<GroupEntity>> fetchGroups();

  Future<int> addGroup({
    required String name,
  });
}
