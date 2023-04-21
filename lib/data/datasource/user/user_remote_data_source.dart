import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
  Future<void> setUserStateStatus(bool isOnline);
  Future<void> updateProfilePic(String path);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage firebaseStorage;

  UserRemoteDataSourceImpl(this.firestore, this.auth, this.firebaseStorage);

  //method getCurrentUserData() which is returning a Future of UserModel or null if there is no data found in the Firestore collection "users"
  // for the current authenticated user.
  @override
  Future<UserModel?> getCurrentUserData() async {
    //The method first attempts to retrieve the user data from the Cloud Firestore database by accessing the "users" collection and getting
    // the document with the ID matching the current user's ID (which is obtained using firebaseAuth.currentUser?.uid).
    var userData = await firestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .get();

    //If the document exists, it is converted to a UserModel object using the fromMap constructor, which takes a Map<String, dynamic> object as input.
    // The data() method is used to retrieve the data from the document as a Map<String, dynamic> object.
    UserModel? userModel;
    if (userData.data() != null) {
      userModel = UserModel.fromMap(userData.data()!);
    }
    return userModel;
  }

  // this function retrieves a stream of updates for a single user document from the Firestore database and converts each update to a UserModel object.
  @override
  Stream<UserModel> getUserById(String id) {
    return firestore
        .collection("users")
        .doc(id)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  //This is an implementation of the setUserStateStatus method that updates the online status and last seen time of a user in a Firestore database.
  @override
  Future<void> setUserStateStatus(bool isOnline) async{
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }

  //The updateProfilePic method is a function that updates the user's profile picture in Firebase.
  @override
  Future<void> updateProfilePic(String path) async {
    String uId = auth.currentUser!.uid;
    //The method first deletes the previous profile picture by checking if the user has a profile picture and calling the _deleteFileFromFirebase method
    // to remove the file from Firebase storage.
    var userData = await firestore.collection('users').doc(uId).get();
    UserModel user = UserModel.fromMap(userData.data()!);
    if(user.profilePicture.isNotEmpty){
      await _deleteFileFromFirebase(user.profilePicture);
    }
    //Then it uploads the new profile picture using the _storeFileToFirebase method and stores the download URL of the new picture in the Firestore database.
    String photoUrl = await _storeFileToFirebase(
      'profilePicture/$uId',
      File(path),
    );
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'profilePicture': photoUrl,
    });
  }
  
  //The _deleteFileFromFirebase method is used to delete the previous profile picture from Firebase storage,
  Future<void> _deleteFileFromFirebase(String path)async{
    return await firebaseStorage.refFromURL(path).delete();
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

}
