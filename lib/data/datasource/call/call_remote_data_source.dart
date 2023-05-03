import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../presentation/pages/main/calls/calling/calling_page.dart';
import '../../../utils/error/exception.dart';
import '../../models/call_model.dart';
import '../../models/user_model.dart';

abstract class CallRemoteDataSource{
  Stream<CallModel> get callStream;

  Stream<List<CallModel>> getCallHistory();

  Future<void> makeCall(BuildContext context,{
    required String receiverId,
    required String receiverName,
    required String receiverPic});

  Future<void> endCall({required String callerId, required String receiverId});
}

class CallRemoteDataSourceImpl extends CallRemoteDataSource{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CallRemoteDataSourceImpl(this._firestore, this._auth);

  Future<UserModel> _currentUser() async {
    var userDataMap =
    await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    UserModel user = UserModel.fromMap(userDataMap.data()!);
    return user;
  }

  //The stream is obtained by listening to changes on a Firestore document in a collection called "call", with the document ID set to the current
  // user's ID obtained from Firebase Authentication.
  //The snapshots() method creates a stream that emits a new DocumentSnapshot every time the document is modified in the database.
  @override
  Stream<CallModel> get callStream {
   return _firestore
       .collection('call')
       .doc(_auth.currentUser!.uid)
       .collection('calling')
       .doc(_auth.currentUser!.uid)
       .snapshots()
       .map((event) => CallModel.fromMap(event.data()!));
  }

  //This code snippet defines an endCall method that deletes two documents from a Firestore collection named call.
  @override
  Future<void> endCall({required String callerId, required String receiverId}) async {
    await _firestore.collection('call').doc(callerId).collection('calling').doc(callerId).delete();
    await _firestore.collection('call').doc(receiverId).collection('calling').doc(receiverId).delete();
  }

  //The method called makeCall which makes a video call between two users in a chat application.
  @override
  Future<void> makeCall(BuildContext context,{
    required String receiverId,
    required String receiverName,
    required String receiverPic
  })async{
    try {
      //It gets the current time when the message is sent using DateTime.now()
      var timeCalling = DateTime.now();
      //The method generates a unique callId using the Uuid package
      String callId = const Uuid().v1();
      //retrieves the details of the current user using the _currentUser method.
      UserModel currentUser = await _currentUser();

      //It then creates two instances of the CallModel class: senderCallData and receiverCallData. These instances are used to store the details of
      // the video call, including the IDs, names, and etc.

      //The senderCallData instance has its hasDialled field set to true, indicating that the call has been initiated by the current user
      CallModel senderCallData = CallModel(
        callerId: currentUser.uId,
        callerName: currentUser.name,
        callerPic: currentUser.profilePicture,
        receiverId: receiverId,
        receiverName: receiverName,
        receiverPic: receiverPic,
        callId: callId,
        hasDialled: true,
        timeCalling: timeCalling
      );

      // while the receiverCallData instance has its hasDialled field set to false, indicating that the call has been received by the other user.
      CallModel receiverCallData = CallModel(
        callerId: currentUser.uId,
        callerName: currentUser.name,
        callerPic: currentUser.profilePicture,
        receiverId: receiverId,
        receiverName: receiverName,
        receiverPic: receiverPic,
        callId: callId,
        hasDialled: false,
        timeCalling: timeCalling
      );

      _saveToCallingSubCollection(senderCallData: senderCallData, receiverCallData: receiverCallData);

      _saveToHistorySubCollection(senderCallData: senderCallData, receiverCallData: receiverCallData);

      //if user make a call automaticly go to CallingPage
      Navigator.pushNamed(
          context,
          CallingPage.routeName,
          arguments: CallingPage(
              channelId: senderCallData.callId,
              call: senderCallData,
              isGroupChat: false
          )
      );

    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw ServerException(e.toString());
    }
  }

  void _saveToCallingSubCollection({required CallModel senderCallData, required CallModel receiverCallData})async{
    //The method then uses the Firebase Firestore API to store the call details in the call collection. It sets the document ID of each call detail
    // instance to the ID of the caller and receiver respectively. The toMap method is used to convert each instance of
    // the CallModel class to a Map, which is then stored in the Firestore database.
    await _firestore
        .collection('call')
        .doc(senderCallData.callerId)
        .collection('calling')
        .doc(senderCallData.callerId)
        .set(senderCallData.toMap());

    await _firestore
        .collection('call')
        .doc(senderCallData.receiverId)
        .collection('calling')
        .doc(senderCallData.callerId)
        .set(receiverCallData.toMap());
  }

  void _saveToHistorySubCollection({required CallModel senderCallData, required CallModel receiverCallData})async{
    //The method then uses the Firebase Firestore API to store the call details in the call collection. It sets the document ID of each call detail
    // instance to the ID of the caller and receiver respectively. The toMap method is used to convert each instance of
    // the CallModel class to a Map, which is then stored in the Firestore database.
    await _firestore
        .collection('call')
        .doc(senderCallData.callerId)
        .collection('history')
        .doc(senderCallData.receiverId)
        .set(senderCallData.toMap());

    await _firestore
        .collection('call')
        .doc(senderCallData.receiverId)
        .collection('history')
        .doc(senderCallData.callerId)
        .set(receiverCallData.toMap());
  }



  // This code provides a way to retrieve a list of chat contacts for the currently authenticated user from Firestore, along with some additional
  // information about each contact.
  @override
  Stream<List<CallModel>> getCallHistory() {
    return _firestore
        .collection("call")
        .doc(_auth.currentUser!.uid)
        .collection("history")
        .snapshots()
        .map((event) => event.docs.map((doc) => CallModel.fromMap(doc.data())).toList());
  }




}