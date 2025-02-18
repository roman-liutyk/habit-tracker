import 'package:habit_tracker/features/habits/domain/entity/habit_entity.dart';

abstract class HabitsRepository {
  Future<List<HabitEntity>> fetchHabits({
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
