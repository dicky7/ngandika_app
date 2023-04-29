part of 'groups_cubit.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();
  @override
  List<Object> get props => [];
}

class GroupsInitial extends GroupsState {}
class SelectContactSuccess extends GroupsState{}
class CreateGroupsError extends GroupsState {
  final String message;

  CreateGroupsError(this.message);

  @override
  List<Object> get props => [message];
}
class CreateGroupsSuccess extends GroupsState {}
