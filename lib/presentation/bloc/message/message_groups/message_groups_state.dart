part of 'message_groups_cubit.dart';

abstract class MessageGroupsState extends Equatable {
  const MessageGroupsState();
  @override
  List<Object> get props => [];
}

class GroupsInitial extends MessageGroupsState {}
class SelectContactSuccess extends MessageGroupsState{}
class CreateGroupsError extends MessageGroupsState {
  final String message;

  CreateGroupsError(this.message);

  @override
  List<Object> get props => [message];
}
class CreateGroupsSuccess extends MessageGroupsState {}
