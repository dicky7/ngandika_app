part of 'bottom_chat_cubit.dart';

abstract class BottomChatState extends Equatable {
  const BottomChatState();
  @override
  List<Object> get props => [];
}

class BottomChatInitial extends BottomChatState {}
class IsShowSendButtonTrueState extends BottomChatState {}
class IsShowSendButtonFalseState extends BottomChatState{}
