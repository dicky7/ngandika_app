import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ngandika_app/utils/error/exception.dart';

abstract class AuthRemoteDataSource {
  Future<void> signInWithPhone(String phoneNumber);
  Future<void> verifyOtp(String smsOtpCode);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  //variable _verificationId use for store the verificationId.
  //Storing the verification ID in a variable is important because it is needed later in the verification process to verify the user's phone number.
  String _verificationId = '';

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

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
          verificationId: _verificationId,
          smsCode: smsOtpCode
      );
      //The function then uses the signInWithCredential method of the firebaseAuth instance to sign in with the provided credential. If the sign-in is
      // successful, the function returns without any errors. If the sign-in fails, the function throws a ServerException with the error message
      // obtained from the FirebaseAuthException caught in the catch block.
      await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message.toString());
    }
  }


}