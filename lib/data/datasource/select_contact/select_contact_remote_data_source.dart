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

  //This method returns a future that resolves to a Set of contacts that are not on the app. The Set is initially populated with the _contactsNotOnApp field,
  // which is an empty Set.
  @override
  Future<List<Contact>> contactsNotOnApp() async => _contactsNotOnApp;

  // This method returns a future that resolves to a map of contacts that are on the app. The map is initially populated with the _contactsOnAppMap field,
  // which appears to be an empty map.
  @override
  Future<Map<String, dynamic>> contactsOnApp() async => _contactsOnAppMap;

  //The getAllContacts method takes a list of Contact objects and populates _contactsNotOnApp and _contactsOnAppMap based on whether the phone numbers
  // in the Contact objects match those in the Firestore database.
  @override
  Future<void> getAllContacts(List<Contact> contacts) async {
    try {
      //First, The method initializes the _contactsNotOnApp and _contactsOnAppMap fields to empty values. These will be populated with contacts that are not on the app and contacts that are on the app.
      _contactsNotOnApp = [];

      //The method then makes a batch query to the Firestore database to retrieve information about each contact in the input contacts list.
      //This is done using the map method to iterate over each contact in contacts, and the Future.wait method to execute all the queries in parallel.
      var userDocs = await Future.wait(contacts.map((contact) =>
          firestore
              .collection("users")
              .where("phoneNumber", isEqualTo: contact.phones.isNotEmpty ? contact.phones.first.number.replaceAll(' ', '') : '')
              .get()));

      print("user docs $userDocs");

      //Once the queries are complete, the method loops over the userDocs list to process the results. For each query result, the method retrieves
      // the userData object from the first document in the query result using the fromMap method of the UserModel class.
      for (int i = 0; i < userDocs.length; i++) {
        var userData;
        var contact = contacts[i];
        print("userDocs[i] ${userDocs.length}");
        if (userDocs[i].docs.isNotEmpty) {
          userData = UserModel.fromMap(userDocs[i].docs.first.data());
          if (userData.uId != auth.currentUser!.uid) {
            _contactsOnAppMap[userData.uId] = {
              'uId': userData.uId,
              'profilePicture': userData.profilePicture,
              'status': userData.status,
              'name': contact.displayName,
            };
            print("on app contact ${_contactsOnAppMap.length}");
            continue;
          }
        }
        _contactsNotOnApp.add(contact);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

}