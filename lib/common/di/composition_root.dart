import 'package:habit_tracker/common/di/dependencies_container.dart';
import 'package:habit_tracker/database/database.dart';
import 'package:habit_tracker/features/groups/data/data_source/groups_data_source.dart';
import 'package:habit_tracker/features/groups/data/repository/groups_repository_impl.dart';
import 'package:habit_tracker/features/groups/domain/repository/groups_repository.dart';
import 'package:habit_tracker/features/habits/data/data_source/habits_data_source.dart';
import 'package:habit_tracker/features/habits/data/repository/habits_repository_impl.dart';
import 'package:habit_tracker/features/habits/domain/repository/habits_repository.dart';

final class CompositionRoot {
  Future<DependenciesContainer> compose() async {
    final HabitsDatabase db = HabitsDatabase();

    final GroupsDataSource groupsDataSource = GroupsDataSourceImpl(db: db);
    final HabitsDataSource habitsDataSource = HabitsDataSourceImpl(db: db);

    await habitsDataSource.resetCompletedHabits();

    final GroupsRepository groupsRepository = GroupsRepositoryImpl(
      groupsDataSource: groupsDataSource,
    );
    final HabitsRepository habitsRepository = HabitsRepositoryImpl(
      habitsDataSource: habitsDataSource,
    );

    return DependenciesContainer(
      groupsRepository: groupsRepository,
      habitsRepository: habitsRepository,
    );
  }
}
