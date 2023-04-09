import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../../../data/models/message_model.dart';
import '../../../../data/repository/chat_repository.dart';
import '../../../../utils/enums/message_type.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;

  ChatCubit(this.repository) : super(ChatInitial());

  Future<void> sendTextMessage({required String text, required String receiverId}) async {
    final result = await repository.sendTextMessage(text: text, receiverId: receiverId);
    result.fold(
      (error) => emit(ChatErrorState(error.message)),
      (success) => emit(SendTextMessageSuccess()),
    );
  }

  Stream<List<MessageModel>> getChatStream(String receiverId) {
    return repository.getChatStream(receiverId);
  }

  Future<void> sendFileMessage({required File file, required String receiverId, required MessageType messageType}) async {
    final result = await repository.sendFileMessage(
        file: file,
        receiverId: receiverId,
        messageType:
        messageType);
    result.fold(
      (e) => emit(ChatErrorState(e.message)),
      (success) => emit(SendFileMessageSuccess()),
    );
  }

  Future<void> sendGIFMessage({required String gifUrl, required String receiverId}) async {
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newGifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    final result = await repository.sendGIFMessage(gifUrl: newGifUrl, receiverId: receiverId);
    result.fold(
          (error) => emit(ChatErrorState(error.message)),
          (success) => emit(SendTextMessageSuccess()),
    );
  }
}
