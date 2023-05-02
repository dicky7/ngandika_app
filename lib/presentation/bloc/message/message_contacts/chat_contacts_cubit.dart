import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/chat_contact_model.dart';
import '../../../../data/repository/message_contats_repository.dart';

part 'chat_contacts_state.dart';

class MessageContactsCubit extends Cubit<MessageContactsState> {
  final MessageContactsRepository repository;

  MessageContactsCubit(this.repository) : super(ChatContactsInitial());

  Stream<List<ChatContactModel>> getChatContacts() {
    return repository.getChatContacts();
  }

  Stream<int> getNumOfMessageNotSeen(String senderId) =>
      repository.getNumOfMessageNotSeen(senderId);
}
