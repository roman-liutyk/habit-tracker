import 'package:habit_tracker/features/habits/data/data_source/habits_data_source.dart';
import 'package:habit_tracker/features/habits/domain/entity/habit_entity.dart';
import 'package:habit_tracker/features/habits/domain/repository/habits_repository.dart';

class HabitsRepositoryImpl implements HabitsRepository {
  const HabitsRepositoryImpl({
    required HabitsDataSource habitsDataSource,
  }) : _habitsDataSource = habitsDataSource;

  final HabitsDataSource _habitsDataSource;

  @override
  Future<int> addHabit({
    required int groupId,
    required String title,
  }) async {
    return await _habitsDataSource.addHabit(groupId: groupId, title: title);
  }

  @override
  Future<void> deleteHabit({
    required int habitId,
  }) async {
    await _habitsDataSource.deleteHabit(habitId: habitId);
  }

  @override
  Future<List<HabitEntity>> fetchHabits({
    required int groupId,
  }) async {
    final habitsTableData =
        await _habitsDataSource.fetchHabits(groupId: groupId);

    return habitsTableData.map(HabitEntity.fromDTO).toList();
  }

  @override
  Future<void> updateHabit({
    required int habitId,
    required bool completed,
  }) async {
    await _habitsDataSource.updateHabit(habitId: habitId, completed: completed);
  }
}
