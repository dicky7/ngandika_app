import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngandika_app/data/models/chat_contact_model.dart';
import 'package:ngandika_app/data/models/user_model.dart';

abstract class MessageContactsRemoteDataSource {
  Stream<List<ChatContactModel>> getChatContacts();

  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class MessageContactsRemoteDataSourceImpl extends MessageContactsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  MessageContactsRemoteDataSourceImpl(this.firestore, this.auth);

  // This code provides a way to retrieve a list of chat contacts for the currently authenticated user from Firestore, along with some additional
  // information about each contact.
  @override
  Stream<List<ChatContactModel>> getChatContacts() {
    // The method first gets the currently authenticated user's uid from FirebaseAuth, and then queries the Firestore database for a collection of chat
    // messages for that user. The result of this query is a Stream of query snapshots.
    return firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .snapshots()
        .asyncMap((event) async {
      // The asyncMap method is used to transform each query snapshot into a List of ChatContactModel objects.
      List<ChatContactModel> messages = [];
      //For each query snapshot, the code iterates through the documents in the snapshot and creates a ChatContactModel object for each document.
      for (var document in event.docs) {
        var chatContact = ChatContactModel.fromMap(document.data());
        //Then, another query is made to fetch the user data of the corresponding contact using the contactId field of the ChatContactModel object.
        var userData = await firestore
            .collection("users")
            .doc(chatContact.contactId)
            .get();
        //The fetched data is then used to create a new UserModel object.
        var user = UserModel.fromMap(userData.data()!);
        //Finally, a new ChatContactModel object is created by combining the information from the ChatContactModel and UserModel objects.
        // This new ChatContactModel object is added to a list of ChatContactModel objects
        messages.add(ChatContactModel(
            name: user.name,
            profilePicture: user.profilePicture,
            contactId: chatContact.contactId,
            lastMessage: chatContact.lastMessage,
            timeSent: chatContact.timeSent));
      }
      return messages;
    });
  }

  //This function returns a stream of integers representing the number of unread messages from a specific sender in a chat.
  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    //The function uses the Firestore to query the database for messages where the senderId matches the specified senderId parameter and the isSeen field is false.
    // The function then uses the snapshots() method to subscribe to real-time updates to the query results and maps the resulting QuerySnapshot to an
    // integer representing the number of documents returned in the snapshot using the length property.
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .where('senderId', isEqualTo: senderId)
        .where('isSeen', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs.length);
  }
}
