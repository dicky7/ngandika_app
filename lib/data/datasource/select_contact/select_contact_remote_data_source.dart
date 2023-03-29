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

  Map<String, dynamic> contactsOnAppMap = {};

  //This method returns a future that resolves to a Set of contacts that are not on the app. The Set is initially populated with the _contactsNotOnApp field,
  // which is an empty Set.
  @override
  Future<List<Contact>> contactsNotOnApp() async => _contactsNotOnApp;

  // This method returns a future that resolves to a map of contacts that are on the app. The map is initially populated with the _contactsOnAppMap field,
  // which appears to be an empty map.
  @override
  Future<Map<String, dynamic>> contactsOnApp() async => contactsOnAppMap;

  //The getAllContacts method takes a list of Contact objects and populates _contactsNotOnApp and _contactsOnAppMap based on whether the phone numbers
  // in the Contact objects match those in the Firestore database.
  @override
  Future<void> getAllContacts(List<Contact> contacts) async {
    _contactsNotOnApp = [];
    Map<String, dynamic> allContacts;

    final userCollection = firestore.collection('users').snapshots();
    final phoneNumbersSet = await userCollection.map((snapshot) {
      final phoneNumbers = snapshot.docs.map((doc) => UserModel.fromMap(doc.data()).phoneNumber).toList();
      return phoneNumbers.toSet();
    }).first;

    await Future.forEach(contacts, (contact) async {
      var phoneNum = contact.phones.isNotEmpty
          ? contact.phones[0].number.replaceAll('-', '').replaceAll(' ', '')
          : '';
      if (phoneNum.startsWith('0')) {
        phoneNum = '+62${phoneNum.substring(1)}';
      } else if (!phoneNum.startsWith('+')) {
        phoneNum = '+$phoneNum';
      }

      if (phoneNumbersSet.contains(phoneNum)) {
        final userDocs = await firestore.collection('users').where('phoneNumber', isEqualTo: phoneNum).get();
        if (userDocs.docs.isNotEmpty) {
          final userDoc = userDocs.docs.first;

          final userData = UserModel.fromMap(userDoc.data());
          if (userData.uId != auth.currentUser!.uid) {
            contactsOnAppMap.addAll({
              userData.uId : {
                'uId': userData.uId,
                'profilePicture': userData.profilePicture,
                'status': userData.status,
                'name': contact.displayName,
              }
            });
            print("_contactsOnAppMap $contactsOnAppMap");
          }
        }
      } else {
        _contactsNotOnApp.add(contact);
      }
    });
  }


}