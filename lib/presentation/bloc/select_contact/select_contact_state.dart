
import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/contact.dart';

abstract class SelectContactState extends Equatable {
  const SelectContactState();

  @override
  List<Object> get props => [];
}

class SelectContactInitial extends SelectContactState {}

class SelectContactLoadingState extends SelectContactState {}

class SelectContactErrorState extends SelectContactState {
  final String message;

  SelectContactErrorState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
class GetAllContactsSuccess extends SelectContactState{}

class GetContactsNotOnAppSuccess extends SelectContactState {
  final List<Contact> contactsNotOnApp;

  GetContactsNotOnAppSuccess(this.contactsNotOnApp);

  @override
  // TODO: implement props
  List<Object> get props => [contactsNotOnApp];
}

class GetContactsOnAppSuccess extends SelectContactState{
  final Map<String, dynamic> contactsOnApp;

  GetContactsOnAppSuccess(this.contactsOnApp);

  @override
  // TODO: implement props
  List<Object> get props => [contactsOnApp];
}
class GetContactsNotOnWhatsSuccessState extends SelectContactState{}
class GetContactsOnWhatsSuccessState extends SelectContactState{}

