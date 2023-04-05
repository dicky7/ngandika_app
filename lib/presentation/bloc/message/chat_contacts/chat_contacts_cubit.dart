import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/chat_contact_model.dart';
import '../../../../data/repository/chat_contats_repository.dart';

part 'chat_contacts_state.dart';

class ChatContactsCubit extends Cubit<ChatContactsState> {
  final ChatContactsRepository repository;

  ChatContactsCubit(this.repository) : super(ChatContactsInitial());

  Stream<List<ChatContactModel>> getChatContacts(){
    return repository.getChatContacts();
  }

  Stream<int> getNumOfMessageNotSeen(String senderId) =>
    repository.getNumOfMessageNotSeen(senderId);



}
