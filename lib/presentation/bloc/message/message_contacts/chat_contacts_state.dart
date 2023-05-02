part of 'chat_contacts_cubit.dart';

abstract class MessageContactsState extends Equatable {
  const MessageContactsState();

  @override
  List<Object> get props => [];
}

class ChatContactsInitial extends MessageContactsState {}

class ChatContactsError extends MessageContactsState {
  final String message;

  ChatContactsError(this.message);

  @override
  List<Object> get props => [message];
}
