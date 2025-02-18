import 'package:habit_tracker/features/groups/domain/repository/groups_repository.dart';
import 'package:habit_tracker/features/habits/domain/repository/habits_repository.dart';

final class DependenciesContainer {
  const DependenciesContainer({
    required this.groupsRepository,
    required this.habitsRepository,
  });

  final GroupsRepository groupsRepository;
  final HabitsRepository habitsRepository;
}
