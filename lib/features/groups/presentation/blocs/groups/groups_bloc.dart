import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/groups/domain/entity/group_entity.dart';
import 'package:habit_tracker/features/groups/domain/repository/groups_repository.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc({
    required GroupsRepository groupsRepository,
  })  : _groupsRepository = groupsRepository,
        super(const GroupsLoading()) {
    on<FetchGroupsEvent>(_fetchGroups);
    on<AddGroupEvent>(_addGroup);
  }

  final GroupsRepository _groupsRepository;

  Future<void> _fetchGroups(
    FetchGroupsEvent event,
    Emitter<GroupsState> emit,
  ) async {
    emit(const GroupsLoading());
    final groups = await _groupsRepository.fetchGroups();
    emit(
      GroupsIdle(
        groups: groups,
      ),
    );
  }

  Future<void> _addGroup(
    AddGroupEvent event,
    Emitter<GroupsState> emit,
  ) async {
    emit(const GroupsLoading());
    await _groupsRepository.addGroup(name: event.name);
    add(const FetchGroupsEvent());
  }
}
