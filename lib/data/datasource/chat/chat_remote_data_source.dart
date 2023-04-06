import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngandika_app/data/models/chat_contact_model.dart';
import 'package:ngandika_app/data/models/user_model.dart';
import 'package:ngandika_app/utils/enums/message_type.dart';
import 'package:ngandika_app/utils/error/exception.dart';
import 'package:uuid/uuid.dart';

import '../../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendTextMessage(
      {required String text, required String receiverId});

  Stream<List<MessageModel>> getChatStream(String receiverId);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRemoteDataSourceImpl(this.firestore, this.auth);

  Future<UserModel> _getCurrentUser() async {
    var userCollection =
        await firestore.collection("users").doc(auth.currentUser!.uid).get();
    UserModel user = UserModel.fromMap(userCollection.data()!);
    return user;
  }

  @override
  Future<void> sendTextMessage(
      {required String text, required String receiverId}) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      var receiverUserCollection =
          await firestore.collection("users").doc(receiverId).get();
      UserModel receiverUserData =
          UserModel.fromMap(receiverUserCollection.data()!);
      UserModel senderUserData = await _getCurrentUser();

      _saveDataToContactsSubCollection(
          senderUserData, receiverUserData, text, timeSent);

      _saveMessageToMessageSubCollection(
          senderId: senderUserData.uId,
          receiverId: receiverId,
          text: text,
          timeSent: timeSent,
          messageId: messageId,
          messageType: MessageType.text,
          receiverUsername: receiverUserData.name,
          senderUsername: senderUserData.name);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // The method uses Firebase Firestore to retrieve messages from a chat between the current user (identified by their user ID) and another user identified by receiverId.
  @override
  Stream<List<MessageModel>> getChatStream(String receiverId) {
    //The method first gets a reference to the Firestore database and constructs a query to fetch messages from the current user's chat with the given receiverId.
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        //The orderBy method is used to sort the messages by the timeSent field in ascending order.
        .orderBy('timeSent')
        //The snapshots method returns a stream of QuerySnapshots that contain the results of the query.
        .snapshots()
        .map((event) {
      //The map function loops over each document in the QuerySnapshot and converts the document data into a MessageModel object using the fromMap
      // method of the MessageModel class.
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        //The resulting MessageModel objects are then added to a list and returned as the result of the map function.
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }

  //this _saveDataToContactsSubCollection function to save the message data to both sender and receiver's chat collections. and show it in contact chat page
  void _saveDataToContactsSubCollection(UserModel senderUserData,
      UserModel receiverUserData, String text, DateTime timeSent) async {
    //The _saveDataToContactsSubCollection function creates two ChatContact objects to store the message data for both the sender and receiver.
    // It includes the sender's name, profile picture, user ID, the text of the last message, and the time it was sent.

    // users -> current user id  => chats -> receiver user id -> set data
    var receiverChatContact = ChatContactModel(
        name: senderUserData.name,
        profilePicture: senderUserData.profilePicture,
        contactId: senderUserData.uId,
        lastMessage: text,
        timeSent: timeSent);
    await firestore
        .collection("users")
        .doc(receiverUserData.uId)
        .collection("chats")
        .doc(senderUserData.uId)
        .set(receiverChatContact.toMap());

    // users -> receiver user id  => chats -> current user id  -> set data
    var senderChatContact = ChatContactModel(
        name: receiverUserData.name,
        profilePicture: receiverUserData.profilePicture,
        contactId: receiverUserData.uId,
        lastMessage: text,
        timeSent: timeSent);
    await firestore
        .collection("users")
        .doc(senderUserData.uId)
        .collection("chats")
        .doc(receiverUserData.uId)
        .set(senderChatContact.toMap());
  }

  // the _saveMessageToMessageSubCollection method is to save a message sent by one user to another user in a sub-collection called messages and
  // allows users to view their chat history and maintain a record of their conversations.
  void _saveMessageToMessageSubCollection(
      {required String senderId,
      required String receiverId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String receiverUsername,
      required String senderUsername,
      required MessageType messageType}) async {
    //The _saveMessageToMessageSubCollection method then stores this MessageModel object in two locations in the Firestore database.
    final message = MessageModel(
        senderId: senderId,
        receiverId: receiverId,
        text: text,
        messageType: messageType,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false);

    // user -> user id -> receiver id -> messages -> messages id -> store message
    //The first location is under the sender's user ID, in a chats collection, which contains a document for the receiver's user ID, which, in turn, contains a messages collection
    await firestore
        .collection("users")
        .doc(senderId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());

    // user -> receiver id ->  user id -> messages -> messages id -> store message
    //The second location is under the receiver's user ID, in a chats collection, which contains a document for the sender's user ID, which, in turn, contains a messages collection.
    await firestore
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(senderId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
  }
}
