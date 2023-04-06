import '../datasource/chat_contacts/chat_contacts_remote_data_source.dart';
import '../models/chat_contact_model.dart';

abstract class ChatContactsRepository {
  Stream<List<ChatContactModel>> getChatContacts();

  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class ChatContactsRepositoryImpl extends ChatContactsRepository {
  final ChatContactsRemoteDataSource remoteDataSource;

  ChatContactsRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<ChatContactModel>> getChatContacts() {
    return remoteDataSource.getChatContacts();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return remoteDataSource.getNumOfMessageNotSeen(senderId);
  }
}
