import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_chat_state.dart';

class BottomChatCubit extends Cubit<BottomChatState> {
  BottomChatCubit() : super(BottomChatInitial());

  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isShowSendButton = false;

  void showSendButton(String val) {
    if (val.trim().isNotEmpty) {
      isShowSendButton = true;
      emit(IsShowSendButtonTrueState());
    } else {
      isShowSendButton = false;
      emit(IsShowSendButtonFalseState());
    }
  }
}
