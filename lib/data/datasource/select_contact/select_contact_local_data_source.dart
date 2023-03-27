import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:ngandika_app/utils/error/exception.dart';

abstract class SelectContactLocalDataSource{
  Future<List<Contact>> getContactLocal();
}

class SelectContactLocalDataSourceImpl extends SelectContactLocalDataSource{

  //This is a method attempts to retrieve a list of contacts from the local device. It uses the FlutterContacts package to access the device's contacts
  @override
  Future<List<Contact>> getContactLocal() async{
    //first checks if the app has permission to access the contacts.
    if(await FlutterContacts.requestPermission()){
      //If the permission is granted, the method calls FlutterContacts.getContacts() to retrieve a list of contacts. The withProperties parameter is set to true,
      // which means that the returned contacts will have their properties (such as name, phone number, and email address).
      return await FlutterContacts.getContacts(withProperties: true);
    }
    // If not, it throws a custom exception with the message "Not Allowed to get contacts".
    else{
      throw DatabaseException('Not Allowed to get contacts');
    }
  }
}