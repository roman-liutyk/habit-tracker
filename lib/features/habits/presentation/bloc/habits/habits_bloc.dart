import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habits/domain/entity/habit_entity.dart';
import 'package:habit_tracker/features/habits/domain/repository/habits_repository.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  HabitsBloc({
    required HabitsRepository habitsRepository,
    required int groupId,
  })  : _habitsRepository = habitsRepository,
        _groupId = groupId,
        super(const HabitsLoading()) {
    on<FetchHabitsEvent>(_fetchHabits);
    on<AddHabitEvent>(_addHabit);
    on<UpdateHabitEvent>(_updateHabit);
  }

  final HabitsRepository _habitsRepository;
  final int _groupId;

  Future<void> _fetchHabits(
    FetchHabitsEvent event,
    Emitter<HabitsState> emit,
  ) async {
    emit(const HabitsLoading());
    final habits = await _habitsRepository.fetchHabits(groupId: _groupId);
    emit(HabitsIdle(habits: habits));
  }

  Future<void> _addHabit(
    AddHabitEvent event,
    Emitter<HabitsState> emit,
  ) async {
    emit(const HabitsLoading());
    await _habitsRepository.addHabit(
      groupId: _groupId,
      title: event.title,
    );
    add(const FetchHabitsEvent());
  }

  Future<void> _updateHabit(
    UpdateHabitEvent event,
    Emitter<HabitsState> emit,
  ) async {
    await _habitsRepository.updateHabit(
      habitId: event.id,
      completed: event.completed,
    );
    add(const FetchHabitsEvent());
  }
}
