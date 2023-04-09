import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'bottom_chat_state.dart';

class BottomChatCubit extends Cubit<BottomChatState> {
  BottomChatCubit() : super(BottomChatInitial());

  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isShowSendButton = false;

  // This method takes a string value as an argument and checks if it is not empty after trimming.
  // If the value is not empty, it sets isShowSendButton to true. Otherwise, it sets isShowSendButton to false
  void showSendButton(String val) {
    if (val.trim().isNotEmpty) {
      isShowSendButton = true;
      emit(IsShowSendButtonTrueState());
    } else {
      isShowSendButton = false;
      emit(IsShowSendButtonFalseState());
    }
  }

  void emojiSelectedShowButton(){
    isShowSendButton = true;
    emit(IsShowSendButtonTrueState());
  }

  // This method sets isShowEmojiContainer to false
  void hideEmojiContainer(){
    isShowEmojiContainer = false;
    emit(HideEmojiContainerState());
  }

  // This method sets isShowEmojiContainer to true
  void showEmojiContainer() {
    isShowEmojiContainer = true;
    emit(ShowEmojiContainerState());
  }

  //The toggleEmojiKeyboard method  is used to show or hide the emoji container or the keyboard,
  // based on the current state of the isShowEmojiContainer boolean variable.
  void toggleEmojiKeyboard(FocusNode focusNode) {
    if (isShowEmojiContainer) {
      hideEmojiContainer();
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
      showEmojiContainer();
    }
  }

}
