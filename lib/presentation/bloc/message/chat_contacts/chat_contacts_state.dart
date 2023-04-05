part of 'chat_contacts_cubit.dart';

abstract class ChatContactsState extends Equatable {
  const ChatContactsState();
  @override
  List<Object> get props => [];
}

class ChatContactsInitial extends ChatContactsState {}
class ChatContactsError extends ChatContactsState{
  final String message;

  ChatContactsError(this.message);
  @override
  List<Object> get props => [message];
}


