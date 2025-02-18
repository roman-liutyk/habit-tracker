part of 'habits_bloc.dart';

sealed class HabitsEvent {
  const HabitsEvent();
}

class FetchHabitsEvent extends HabitsEvent {
  const FetchHabitsEvent({
    required this.groupId,
  });

  final int groupId;
}
