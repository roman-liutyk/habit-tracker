part of 'habits_bloc.dart';

sealed class HabitsState {
  const HabitsState();
}

final class HabitsLoading extends HabitsState {
  const HabitsLoading();
}

final class HabitsIdle extends HabitsState {
  const HabitsIdle({
    required this.habits,
  });

  final List<HabitEntity> habits;
}
