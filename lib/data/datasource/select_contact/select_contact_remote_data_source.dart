import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:ngandika_app/data/models/user_model.dart';

import '../../../utils/error/exception.dart';

abstract class SelectContactRemoteDataSource{
  Future<void> getAllContacts(List<Contact> contact);
  Future<Map<String, dynamic>> contactsOnApp();
  Future<List<Contact>> contactsNotOnApp();

}

class SelectContactRemoteDataSourceImpl extends SelectContactRemoteDataSource{
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  SelectContactRemoteDataSourceImpl(this.firestore, this.auth);

  List<Contact> _contactsNotOnApp = [];

  Map<String, dynamic> _contactsOnAppMap = {};

  // This method returns a future that resolves to a list of contacts that are not on the app. The list is initially populated with the
  // _contactsNotOnApp field, which appears to be an empty list.
  @override
  Future<List<Contact>> contactsNotOnApp() async => _contactsNotOnApp;

  // This method returns a future that resolves to a map of contacts that are on the app. The map is initially populated with the _contactsOnAppMap field,
  // which appears to be an empty map.
  @override
  Future<Map<String, dynamic>> contactsOnApp() async => _contactsOnAppMap;

  //The getAllContacts method takes a list of Contact objects and populates _contactsNotOnApp and _contactsOnAppMap based on whether the phone numbers
  // in the Contact objects match those in the Firestore database.
  @override
  Future<void> getAllContacts(List<Contact> contact) async {
    try {
      //Clears _contactsNotOnApp to start with an empty list.
      _contactsNotOnApp = [];
      //Gets all documents from the "users" collection in the Firestore database using the get method.
      var userCollection = await firestore.collection("users").get();
      String phoneNumber;
      bool isNumberFound = false;
      //Loops through each Contact object in the input list and extracts its phone number (if available) by removing spaces from the first phone number in its phones list.
      for (int index = 0; index < contact.length; index++) {
        isNumberFound = false;
        phoneNumber = contact[index].phones.isNotEmpty
            ? contact[index].phones[0].number.replaceAll(' ', '')
            : '';

        //For each Contact object, it loops through all documents in the "users" collection
        for (var document in userCollection.docs) {
          var userData = UserModel.fromMap(document.data());
          //checks if the phone number matches that of the user's phone number in the Firestore document.
          //If a match is found and the user is not the currently authenticated user, it adds the user's information (uId, profilePic, status, and name) to the contactsOnAppMap map.
          if (phoneNumber == userData.phoneNumber &&
              userData.uId != auth.currentUser!.uid) {
            _contactsOnAppMap.addAll({
              userData.uId: {
                'uId': userData.uId,
                'profilePic': userData.profilePicture,
                'status': userData.status,
                'name': contact[index].displayName,
              }
            });
            isNumberFound = true;
            break;
          }
        }
        //If a match is not found, it adds the Contact object to the _contactsNotOnApp list.
        if (!isNumberFound) _contactsNotOnApp.add(contact[index]);
      }
    }catch(e){
      throw ServerException(e.toString());
    }
  }
}