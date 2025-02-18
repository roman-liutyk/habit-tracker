part of 'groups_bloc.dart';

sealed class GroupsEvent {
  const GroupsEvent();
}

final class FetchGroupsEvent extends GroupsEvent {
  const FetchGroupsEvent();
}

final class AddGroupEvent extends GroupsEvent {
  const AddGroupEvent({
    required this.name,
  });

  final String name;
}
