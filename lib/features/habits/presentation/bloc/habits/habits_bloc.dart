import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habits/domain/entity/habit_entity.dart';
import 'package:habit_tracker/features/habits/domain/repository/habits_repository.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  HabitsBloc({required HabitsRepository habitsRepository})
      : _habitsRepository = habitsRepository,
        super(const HabitsLoading()) {
    on<FetchHabitsEvent>(_fetchHabits);
  }

  final HabitsRepository _habitsRepository;

  Future<void> _fetchHabits(
    FetchHabitsEvent event,
    Emitter<HabitsState> emit,
  ) async {
    emit(const HabitsLoading());
    final habits = await _habitsRepository.fetchHabits(groupId: event.groupId);
    emit(HabitsIdle(habits: habits));
  }
}
