import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:ngandika_app/data/models/group_model.dart';
import 'package:ngandika_app/utils/error/exception.dart';
import 'package:uuid/uuid.dart';

abstract class GroupsRemoteDataSource {
  Future<void> createGroup(String name, File profilePicture, List<String> selectedUidContact);
  Stream<List<GroupModel>> getChatGroups();
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class GroupsRemoteDataSourceImpl extends GroupsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage firebaseStorage;

  GroupsRemoteDataSourceImpl(this.firestore, this.auth, this.firebaseStorage);

  //The createGroup method is a function that creates a new group in a messaging application.
  @override
  Future<void> createGroup(String name, File profilePicture, List<String> selectedUidContact) async {
    try {
      // the first thing that is done is to generate a unique ID for the group using the Uuid().v1() method
      var groupId = const Uuid().v1();

      //uploads the groupProfilePic picture using the _storeFileToFirebase method and stores the download URL of the new picture in the Firestore database.
      String groupPhotoUrl = await _storeFileToFirebase(
        'group/$groupId',
        File(profilePicture.path),
      );

      //After that, a GroupModel object is created using the parameters passed to the method and some additional information, such as the sender ID
      // of the user who created the group and membersUid, where membersUid includes the UIDs of the current user and the selected members.
      GroupModel group = GroupModel(
          senderId: auth.currentUser!.uid,
          name: name,
          groupId: groupId,
          lastMessage: '',
          groupProfilePic: groupPhotoUrl,
          timeSent: DateTime.now(),
          membersUid: [auth.currentUser!.uid, ...selectedUidContact]
      );

      //Finally, the GroupModel object is saved to the groups collection in Firestore with the doc method, where the document ID is the unique ID generated at the beginning of the method.
      await firestore.collection("groups").doc(groupId).set(group.toMap());
    } catch (e) {
      if (kDebugMode) print(e.toString());
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

  @override
  Stream<List<GroupModel>> getChatGroups() {
    return firestore
        .collection("groups")
        .snapshots()
        .asyncMap((event) {
      List<GroupModel> groupsMessage = [];
      for (var document in event.docs) {
        var chatGroup = GroupModel.fromMap(document.data());
        if (chatGroup.membersUid.contains(auth.currentUser!.uid)) {
         groupsMessage.add(chatGroup);
        }
      }
      return groupsMessage;
    });
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    // TODO: implement getNumOfMessageNotSeen
    throw UnimplementedError();
  }


}