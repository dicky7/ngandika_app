
import '../datasource/message_contacts/message_contacts_remote_data_source.dart';
import '../models/chat_contact_model.dart';

abstract class MessageContactsRepository {
  Stream<List<ChatContactModel>> getChatContacts();

  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class MessageContactsRepositoryImpl extends MessageContactsRepository {
  final MessageContactsRemoteDataSource remoteDataSource;

  MessageContactsRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<ChatContactModel>> getChatContacts() {
    return remoteDataSource.getChatContacts();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return remoteDataSource.getNumOfMessageNotSeen(senderId);
  }
}
