import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
  Future<void> setUserStateStatus(bool isOnline);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  UserRemoteDataSourceImpl(this.firestore, this.firebaseAuth);

  //method getCurrentUserData() which is returning a Future of UserModel or null if there is no data found in the Firestore collection "users"
  // for the current authenticated user.
  @override
  Future<UserModel?> getCurrentUserData() async {
    //The method first attempts to retrieve the user data from the Cloud Firestore database by accessing the "users" collection and getting
    // the document with the ID matching the current user's ID (which is obtained using firebaseAuth.currentUser?.uid).
    var userData = await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
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
    await firestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }


}
