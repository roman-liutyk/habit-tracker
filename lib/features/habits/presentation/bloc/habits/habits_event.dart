part of 'habits_bloc.dart';

sealed class HabitsEvent {
  const HabitsEvent();
}

class FetchHabitsEvent extends HabitsEvent {
  const FetchHabitsEvent();
}

class AddHabitEvent extends HabitsEvent {
  const AddHabitEvent({
    required this.title,
  });

  final String title;
}

class UpdateHabitEvent extends HabitsEvent {
  const UpdateHabitEvent({
    required this.id,
    required this.completed,
  });

  final int id;
  final bool completed;
}
