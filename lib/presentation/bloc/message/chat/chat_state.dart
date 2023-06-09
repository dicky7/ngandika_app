import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatErrorState extends ChatState {
  final String message;

  const ChatErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SendTextMessageSuccess extends ChatState {}
class SendFileMessageSuccess extends ChatState{}

class MessageSelected extends ChatState{}
class SelectedMessageIndexCleared extends ChatState{}

class CancelReplayState extends ChatState{}
class MessageSwipeState extends ChatState{}

class MessageSeenSuccess extends ChatState{}
