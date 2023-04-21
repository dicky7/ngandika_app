import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:ngandika_app/data/models/user_model.dart';

import '../../../utils/error/exception.dart';

abstract class SelectContactRemoteDataSource {
  Future<void> getAllContacts(List<Contact> contact);

  Future<Map<String, dynamic>> contactsOnApp();

  Future<List<Contact>> contactsNotOnApp();
}

class SelectContactRemoteDataSourceImpl extends SelectContactRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  SelectContactRemoteDataSourceImpl(this.firestore, this.auth);

  List<Contact> _contactsNotOnApp = [];

  Map<String, dynamic> contactsOnAppMap = {};

// This method returns a stream that emits the map of contacts that are on the app.
  @override
  Future<Map<String, dynamic>> contactsOnApp() async => contactsOnAppMap;

  // This method returns a stream that emits the list of contacts that are not on the app.
  @override
  Future<List<Contact>> contactsNotOnApp() async => _contactsNotOnApp;

  @override
  Future<void> getAllContacts(List<Contact> contacts) async {
    try {
      _contactsNotOnApp = [];

      // Use a set to remove duplicates
      final contactSet = contacts.toSet();

      // Use Future.wait() for parallel execution
      final results = await Future.wait(contactSet.map((contact) async {
        var phoneNumber = contact.phones.isNotEmpty
            ? contact.phones[0].number.replaceAll(' ', '').replaceAll('-', '')
            : '';
        if (phoneNumber.isEmpty) return null;

        // Add the following code to convert the phone number to the desired format
        if (phoneNumber.startsWith('0')) {
          phoneNumber = '+62${phoneNumber.substring(1)}';
        } else if (!phoneNumber.startsWith('+')) {
          phoneNumber = '+$phoneNumber';
        }

        // Use querySnapshot instead of get() with a where() clause
        final querySnapshot = await firestore
            .collection('users')
            .where('phoneNumber', isEqualTo: phoneNumber)
            .get();
        if (querySnapshot.size == 0) {
          _contactsNotOnApp.add(contact);
          return null;
        }

        // Use batch to perform multiple writes in a single operation
        final batch = firestore.batch();
        querySnapshot.docs.forEach((document) {
          final userData = UserModel.fromMap(document.data());
          final data = {
            'uId': userData.uId,
            'profilePicture': userData.profilePicture,
            'status': userData.status,
            'name': userData.name,
            // 'name': contact.displayName,
          };
          batch.set(
              firestore
                  .collection('contacts')
                  .doc(auth.currentUser!.uid)
                  .collection('users')
                  .doc(userData.uId),
              data);
          contactsOnAppMap[userData.uId] = data;
        });
        await batch.commit();
      }).whereType<Future>());

      // Remove null results from Future.wait()
      _contactsNotOnApp.addAll(results.whereType<Contact>());

      // Sort the contacts in ascending order based on their display name
      _contactsNotOnApp.sort((a, b) => a.displayName.compareTo(b.displayName));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
