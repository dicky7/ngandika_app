import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:ngandika_app/data/models/user_model.dart';
import 'package:ngandika_app/utils/error/exception.dart';

abstract class AuthRemoteDataSource {
  Future<void> signInWithPhone(String phoneNumber);

  Future<void> verifyOtp(String smsOtpCode);

  Future<void> saveUserDataToFirebase(String userName, File? profilePicture);

  Future<String> storeFileToFirebase(String path, File file);

  Future<String> getCurrentUid();

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  //variable _verificationId use for store the verificationId.
  //Storing the verification ID in a variable is important because it is needed later in the verification process to verify the user's phone number.
  String _verificationId = '';

  AuthRemoteDataSourceImpl(
      this.firebaseAuth, this.firestore, this.firebaseStorage);

  @override
  Future<void> signInWithPhone(String phoneNumber) async {
    try {
      //The verifyPhoneNumber method takes several optional parameters to handle different stages of the verification process.
      // In this implementation, the following callback functions are defined:
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        //verificationCompleted: called when the phone number verification is successfully completed, passing a PhoneAuthCredential object
        // as a parameter that can be used to sign in the user.
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
          if (kDebugMode) {
            print("phone verified : Token ${credential.token}");
          }
        },
        // The verificationFailed callback is called when there is an error during the verification process, and it throws a ServerException with
        // the error message.
        verificationFailed: (e) {
          throw ServerException(e.message.toString());
        },
        // The codeSent callback is called when a verification code is sent to the user's phone, and it saves the verification ID in the _verificationId variable.
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        //codeAutoRetrievalTimeout: called when the verification code retrieval times out, passing the verificationId as a parameter.
        codeAutoRetrievalTimeout: (String verificationId) {
          if (kDebugMode) {
            print("time out :$verificationId");
          }
        },
        timeout: const Duration(minutes: 1),
      );
      //If the verifyPhoneNumber method throws a FirebaseAuthException, it is caught and converted into a ServerException and thrown.
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  // this code is used to verify the OTP code received via SMS and sign in the user using Firebase Authentication's phone number authentication.
  @override
  Future<void> verifyOtp(String smsOtpCode) async {
    try {
      //The function first creates a PhoneAuthCredential object using the _verificationId and smsOtpCode parameters. The _verificationId is obtained during
      // the phone number verification process using Firebase's Phone Authentication API. The smsOtpCode is the OTP code sent to the phone number via SMS.
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsOtpCode);
      //The function then uses the signInWithCredential method of the firebaseAuth instance to sign in with the provided credential. If the sign-in is
      // successful, the function returns without any errors. If the sign-in fails, the function throws a ServerException with the error message
      // obtained from the FirebaseAuthException caught in the catch block.
      await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  //This two methods - saveUserDataToFirebase and storeFileToFirebase, that work together to save user data, including a user's name, profile picture, and other information, to Firebase.
  @override
  Future<void> saveUserDataToFirebase(
      String userName, File? profilePicture) async {
    try {
      //The method first gets the current user's unique ID by calling the uid property on the currentUser object of the firebaseAuth instance.
      String uId = firebaseAuth.currentUser!.uid;

      //Then, it checks if profilePicture is not null, and if it is not null, it uploads the file to Firebase Storage using the storeFileToFirebase
      // method and sets the resulting URL as the value of the photoUrl variable.
      String photoUrl = "";
      if (profilePicture != null) {
        photoUrl = await storeFileToFirebase("profilePic/$uId", profilePicture);
      }
      //After that, it creates a UserModel object with the provided userName, uId, phoneNumber, profilePicture, isOnline, and an empty groupId array.
      var user = UserModel(
        name: userName,
        uId: uId,
        profilePicture: photoUrl,
        isOnline: true,
        phoneNumber: firebaseAuth.currentUser!.phoneNumber!,
        groupId: [],
        status: 'Hey,$userName Here!',
        lastSeen: DateTime.now(),
      );

      //check if collection "users" is exist or not, if exists update the users collection using update method with the current id
      //The toMap method is called on this UserModel instance to obtain a Map representation of the user data.
      var userDoc = await firestore.collection("users").doc(uId).get();
      if (userDoc.exists) {
        await firestore.collection('users').doc(uId).update(user.toMap());
      } else {
        //if collection "users" is not exist, it saves the UserModel object to the users collection in Firestore using the set method on a
        // document with the current user's uId.
        await firestore.collection("users").doc(uId).set(user.toMap());
      }
    } on FirebaseFirestore catch (e) {
      throw ServerException(e.toString());
    }
  }

  //This is method uploads a file to Firebase Storage and returns the download URL of the uploaded file.
  @override
  Future<String> storeFileToFirebase(String path, File file) async {
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
  Future<String> getCurrentUid() async {
    try {
      //The method first gets the current user's unique ID by calling the uid property on the currentUser object of the firebaseAuth instance.
      String uId = firebaseAuth.currentUser!.uid;
      return uId;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<void> signOut() async {
   await firebaseAuth.signOut();
  }
}
