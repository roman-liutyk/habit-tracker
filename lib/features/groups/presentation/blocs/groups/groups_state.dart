part of 'groups_bloc.dart';

sealed class GroupsState {
  const GroupsState();
}

final class GroupsLoading extends GroupsState {
  const GroupsLoading();
}

final class GroupsIdle extends GroupsState {
  const GroupsIdle({
    required this.groups,
  });

  final List<GroupEntity> groups;
}
