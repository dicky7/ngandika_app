import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/message_model.dart';
import '../../../../data/repository/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;

  ChatCubit(this.repository) : super(ChatInitial());

  Future<void> sendTextMessage({required String text, required String receiverId}) async{
    final result = await repository.sendTextMessage(text: text, receiverId: receiverId);
    result.fold(
      (error) => emit(ChatErrorState(error.message)),
      (success) => emit(SendTextMessageSuccess()),
    );
  }

  Stream<List<MessageModel>> getChatStream(String receiverId){
    return repository.getChatStream(receiverId);
  }
}
