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
    print('_auth.currentUser!.uid ${_auth.currentUser!.uid}');
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

      //Then, both instances of CallModel are passed to the _saveToCallingSubCollection and _saveToHistorySubCollection functions.
      // These functions save the details of the video call in the Firestore database in separate collections named "calling" and "history," respectively.
      _saveToCallingSubCollection(senderCallData: senderCallData, receiverCallData: receiverCallData);

      _saveToHistorySubCollection(senderCallData: senderCallData, receiverCallData: receiverCallData);

      //Finally, if the user makes a call, the makeCall function automatically navigates the user to the CallingPage with the relevant details of the video call.
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

  //The _saveToCallingSubCollection function is responsible for saving the details of the video call in the Firestore database.
  void _saveToCallingSubCollection({required CallModel senderCallData, required CallModel receiverCallData})async{
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
        .doc(senderCallData.receiverId)
        .set(receiverCallData.toMap());
  }

  //The _saveToHistorySubCollection function is responsible for saving the details of the video call in the Firestore database for historical purposes.
  void _saveToHistorySubCollection({required CallModel senderCallData, required CallModel receiverCallData})async{
    await _firestore
        .collection('call')
        .doc(senderCallData.callerId)
        .collection('history')
        .doc(senderCallData.callId)
        .set(senderCallData.toMap());

    await _firestore
        .collection('call')
        .doc(senderCallData.receiverId)
        .collection('history')
        .doc(senderCallData.callId)
        .set(receiverCallData.toMap());
  }

  //The getCallHistory function returns a stream of List<CallModel> objects, which represents the call history of a user.
  @override
  Stream<List<CallModel>> getCallHistory() {
    return _firestore
        .collection("call")
        .doc(_auth.currentUser!.uid)
        .collection("history")
    //the snapshots() method is used to create a stream of query snapshots, which updates the stream whenever the underlying data changes in the database.
        .snapshots()
    // The map() method is then called on the stream to transform the snapshots into a list of CallModel objects.
        .map((event) =>
    //The CallModel.fromMap method is used to convert the Firestore document data (represented as a Map<String, dynamic>) into a CallModel object.
    //This is done for each document in the snapshot, resulting in a list of CallModel objects.
        event.docs.map((doc) => CallModel.fromMap(doc.data())).toList());
  }
}