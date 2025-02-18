import 'package:habit_tracker/database/database.dart';

class HabitEntity {
  final int id;
  final String title;
  final int groupId;
  final bool completed;
  final DateTime lastModifiedAt;
  final DateTime createdAt;

  const HabitEntity({
    required this.id,
    required this.title,
    required this.groupId,
    required this.completed,
    required this.lastModifiedAt,
    required this.createdAt,
  });

  factory HabitEntity.fromDTO(
    HabitsTableData data,
  ) =>
      HabitEntity(
        id: data.id,
        title: data.title,
        groupId: data.group,
        completed: data.completed,
        lastModifiedAt: data.lastModifiedAt,
        createdAt: data.createdAt,
      );
}
