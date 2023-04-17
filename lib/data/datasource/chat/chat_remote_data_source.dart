import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ngandika_app/data/models/chat_contact_model.dart';
import 'package:ngandika_app/data/models/user_model.dart';
import 'package:ngandika_app/utils/enums/message_type.dart';
import 'package:ngandika_app/utils/error/exception.dart';
import 'package:ngandika_app/utils/error/failure.dart';
import 'package:uuid/uuid.dart';

import '../../models/message_model.dart';
import '../../models/message_reply_model.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendTextMessage({required String text, required String receiverId, required MessageReplyModel? messageReply});
  Future<void> sendGIFMessage({required String gifUrl, required String receiverId, required MessageReplyModel? messageReply});
  Stream<List<MessageModel>> getChatStream(String receiverId);
  Future<void> sendFileMessage({required File file, required String receiverId, required MessageType messageType, required MessageReplyModel? messageReply});
  Future<void> setMessageSeen(String receiverId, String messageId);

}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage firebaseStorage;

  ChatRemoteDataSourceImpl(this.firestore, this.auth, this.firebaseStorage);

  Future<UserModel> _getCurrentUser() async {
    var userCollection = await firestore.collection("users").doc(auth.currentUser!.uid).get();
    UserModel user = UserModel.fromMap(userCollection.data()!);
    return user;
  }

  // The sendTextMessage method is a function that sends a text message from the current user to a receiver user in a chat application.
  @override
  Future<void> sendTextMessage({required String text, required String receiverId, required MessageReplyModel? messageReply}) async {
    try {
      //It gets the current time when the message is sent using DateTime.now()
      var timeSent = DateTime.now();
      // generates a unique message ID using Uuid().v1().
      var messageId = const Uuid().v1();
      //Retrieves the current user's data using the _getCurrentUser() method.
      UserModel senderUserData = await _getCurrentUser();
      var receiverUserCollection = await firestore.collection("users").doc(receiverId).get();
      UserModel receiverUserData = UserModel.fromMap(receiverUserCollection.data()!);

      //It calls the _saveDataToContactsSubCollection method to save the message data to both the sender and receiver's chat collections,
      // which includes their names, profile pictures, user IDs, the text of the last message, and the time it was sent.
      _saveDataToContactsSubCollection(
          senderUserData,
          receiverUserData,
          text,
          timeSent
      );
      //calls the _saveMessageToMessageSubCollection method to save the message in a sub-collection called messages under both the sender and
      // receiver's chat collections, which allows users to view their chat history and maintain a record of their conversations.
      // It includes the sender's and receiver's IDs, the text of the message, the type of message (in this case, text), and more
      _saveMessageToMessageSubCollection(
          senderId: senderUserData.uId,
          receiverId: receiverId,
          text: text,
          timeSent: timeSent,
          messageId: messageId,
          messageType: MessageType.text,
          receiverUsername: receiverUserData.name,
          senderUsername: senderUserData.name,
          messageReply: messageReply
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // The sendGIFMessage method is a function that sends a GIF message from the current user to a receiver user in a chat application.
  @override
  Future<void> sendGIFMessage({required String gifUrl, required String receiverId, required MessageReplyModel? messageReply}) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      UserModel senderUserData = await _getCurrentUser();
      var receiverUserCollection = await firestore.collection("users").doc(receiverId).get();
      UserModel receiverUserData = UserModel.fromMap(receiverUserCollection.data()!);

      _saveDataToContactsSubCollection(
          senderUserData,
          receiverUserData,
          "GIF",
          timeSent
      );
      _saveMessageToMessageSubCollection(
          senderId: senderUserData.uId,
          receiverId: receiverId,
          text: gifUrl,
          timeSent: timeSent,
          messageId: messageId,
          messageType: MessageType.gif,
          receiverUsername: receiverUserData.name,
          senderUsername: senderUserData.name,
          messageReply: messageReply
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
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
  void _saveMessageToMessageSubCollection({
    required String senderId,
      required String receiverId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String receiverUsername,
      required String senderUsername,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
  }) async {
    //The _saveMessageToMessageSubCollection method then stores this MessageModel object in two locations in the Firestore database.
    final message = MessageModel(
        senderId: senderId,
        receiverId: receiverId,
        text: text,
        messageType: messageType,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false,
        repliedMessage: messageReply == null ? '' : messageReply.message,
        senderName: senderUsername,
        repliedTo: messageReply == null
            ? ''
            : messageReply.isMe
              ? senderUsername
              : messageReply.repliedTo,
      repliedMessageType: messageReply == null ? MessageType.text : messageReply.messageType,
    );

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

  //The sendFileMessage method is used to send a file message from one user to another in a chat application.
  @override
  Future<void> sendFileMessage({
    required File file,
    required String receiverId,
    required MessageType messageType,
    required MessageReplyModel? messageReply}) async{

    try{
      //It gets the current date and time when the message is sent
      var timeSent = DateTime.now();
      //generates a unique message ID
      var messageId = const Uuid().v1();
      //It retrieves the sender user's data by calling the _getCurrentUser() method.
      UserModel senderUserData = await _getCurrentUser();
      var receiverUserCollection = await firestore.collection("users").doc(receiverId).get();
      UserModel receiverUserData = UserModel.fromMap(receiverUserCollection.data()!);

      //Stores the file to Firebase Storage using the _storeFileToFirebase() method, which uploads the file to Firebase Storage and
      // returns the download URL of the uploaded file.
      var fileUrl = await _storeFileToFirebase(
        'chat/${messageType.type}/${senderUserData.uId}/$receiverId/$messageId}', file,
      );

      String contactMessage;
      switch (messageType) {
        case MessageType.image:
          contactMessage = '📷 Photo';
          break;
        case MessageType.video:
          contactMessage = '🎥 Video';
          break;
        case MessageType.audio:
          contactMessage = '🎙️ Audio';
          break;
        case MessageType.gif:
          contactMessage = 'Gif';
          break;
        default:
          contactMessage = 'Other';
      }

      //this only show in contact chat, and show in the last text message like String photo and etc.
      ////Saves the contact message data to both the sender and receiver's chat collections in the Firestore database using the _saveDataToContactsSubCollection() method.
      _saveDataToContactsSubCollection(
          senderUserData,
          receiverUserData,
          contactMessage,
          timeSent
      );

      //Saves the message data to the sender's and receiver's message sub-collections in the Firestore database using the _saveMessageToMessageSubCollection() method.
      // This includes the sender ID, receiver ID, text of the message (which is the download URL of the uploaded file), message type, and more
      _saveMessageToMessageSubCollection(
          senderId: senderUserData.uId,
          receiverId: receiverId,
          text: fileUrl,
          timeSent: timeSent,
          messageId: messageId,
          receiverUsername: receiverUserData.name,
          senderUsername: senderUserData.name,
          messageType: messageType,
          messageReply: messageReply
      );
    }catch (e){
      throw ServerException(e.toString());
    }
  }


  //This is method uploads a file to Firebase Storage and returns the download URL of the uploaded file.
  Future<String> _storeFileToFirebase(String path, File file) async {
    //First, the method creates an UploadTask object using the putFile method of the Firebase Storage reference. The path parameter is used as
    // the path of the file in Firebase Storage, and the file parameter is used as the actual file to be uploaded
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    //Next, the method waits for the upload to complete by awaiting the UploadTask object. The result of the upload is a TaskSnapshot object,
    // which contains information about the uploaded file, such as its download URL.
    TaskSnapshot snapshot = await uploadTask;
    //Finally, the method gets the download URL of the uploaded file by calling the getDownloadURL method on the TaskSnapshot object, and returns it as a String.
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //The function for marking a message as seen
  //Inside the function, there are two update operations being performed using await on two different documents in Firestore.

  @override
  Future<void> setMessageSeen(String receiverId, String messageId) async{
    try{
      // The first update operation marks the message as seen in the sender's chat,
      // The isSeen field is updated to true in both cases, indicating that the message has been seen.
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("chats")
          .doc(receiverId)
          .collection("messages")
          .doc(messageId)
          .update({'isSeen': true});

      // while the second update operation marks the same message as seen in the receiver's chat.
      await firestore
          .collection("users")
          .doc(receiverId)
          .collection("chats")
          .doc(auth.currentUser!.uid)
          .collection("messages")
          .doc(messageId)
          .update({'isSeen': true});

    }catch (e){
      throw ServerException(e.toString());
    }
  }

}
