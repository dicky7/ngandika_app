import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ngandika_app/data/models/message_reply_model.dart';

import '../../../../data/models/message_model.dart';
import '../../../../data/repository/chat_repository.dart';
import '../../../../utils/enums/message_type.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;

  bool isPressed = false;
  int selectedMessageIndex = -1; // Add the isPressed variable here
  ChatCubit(this.repository) : super(ChatInitial());

  MessageReplyModel? messageReplay;

  //set messageReplay to null if user click cancel replay
  void cancelReplay() {
    messageReplay = null;
    emit(CancelReplayState());
  }

  //when user swipe it'll insert the value from parameter into messageReplay
  void onMessageSwipe({
    required String message,
    required bool isMe,
    required MessageType messageType,
    required String repliedTo
  }) {
    messageReplay = MessageReplyModel(
      message: message,
      isMe: isMe,
      messageType: messageType,
      repliedTo: repliedTo,
    );
    emit(MessageSwipeState());
  }

  Future<void> sendTextMessage({required String text, required String receiverId}) async {
    final result = await repository.sendTextMessage(text: text, receiverId: receiverId, messageReply: messageReplay);
    //set messageReplay to null after sending data and it'll make replay preview disappear
    messageReplay = null;
    result.fold(
      (error) => emit(ChatErrorState(error.message)),
      (success) => emit(SendTextMessageSuccess()),
    );
  }

  Stream<List<MessageModel>> getChatStream(String receiverId) {
    return repository.getChatStream(receiverId);
  }

  Future<void> sendFileMessage({required File file, required String receiverId, required MessageType messageType}) async {
    final result = await repository.sendFileMessage(file: file, receiverId: receiverId, messageType: messageType, messageReply: messageReplay);
    messageReplay = null;
    result.fold(
      (e) => emit(ChatErrorState(e.message)),
      (success) => emit(SendFileMessageSuccess()),
    );
  }

  Future<void> sendGIFMessage({required String gifUrl, required String receiverId}) async {
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newGifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    final result = await repository.sendGIFMessage(gifUrl: newGifUrl, receiverId: receiverId, messageReply: messageReplay);
    messageReplay = null;
    result.fold(
          (error) => emit(ChatErrorState(error.message)),
          (success) => emit(SendTextMessageSuccess()),
    );
  }

  // Update the value of isPressed
  void updateIsPressed(int  selectedIndex, MessageModel message) {
    isPressed = true;
    selectedMessageIndex = selectedIndex;
    emit(MessageSelected()); // Emit a state updated event
  }

  void clearSelectedIndex() {
    isPressed = false;
    selectedMessageIndex = -1; // Clear the selectedIndex value
    emit(SelectedMessageIndexCleared());
  }

}
