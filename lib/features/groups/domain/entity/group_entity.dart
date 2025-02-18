import 'package:habit_tracker/database/database.dart';

class GroupEntity {
  const GroupEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GroupEntity.fromDTO(
    GroupsTableData data,
  ) =>
      GroupEntity(
        id: data.id,
        name: data.name,
      );
}
