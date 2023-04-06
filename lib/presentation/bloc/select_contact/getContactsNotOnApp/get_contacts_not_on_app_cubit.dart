import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/contact.dart';

import '../../../../data/repository/select_contact_repository.dart';

part 'get_contacts_not_on_app_state.dart';

class GetContactsNotOnAppCubit extends Cubit<GetContactsNotOnAppState> {
  final SelectContactRepository repository;

  GetContactsNotOnAppCubit(this.repository)
      : super(GetContactsNotOnAppInitial());

  int _totalContacts =
      0; // class-level variable to store the total number of contacts
  int get totalContacts =>
      _totalContacts; // getter method to access the total number of contacts

  List<Contact> _contactsNotOnApp = [];

  List<Contact> get contactsNotOnApp => _contactsNotOnApp;

  Future<void> getContactsNotOnApp() async {
    emit(GetContactsNotOnAppLoading());
    _totalContacts = 0; // Reset total number of contacts to 0
    final result = await repository.contactsNotOnApp();
    result.fold(
      (error) => emit(GetContactsNotOnAppError(error.message)),
      (success) {
        _totalContacts += success.length; // update total number of contacts
        _contactsNotOnApp.addAll(success);
        emit(GetContactsNotOnAppSuccess());
      },
    );
  }
}
