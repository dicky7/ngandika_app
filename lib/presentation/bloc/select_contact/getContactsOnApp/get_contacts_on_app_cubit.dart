import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/select_contact_repository.dart';
import 'get_contacts_on_app_state.dart';


class GetContactsOnAppCubit extends Cubit<GetContactsOnAppState> {
  final SelectContactRepository repository;
  GetContactsOnAppCubit(this.repository) : super(GetContactsOnAppInitial());


  int _totalContacts = 0; // class-level variable to store the total number of contacts
  int get totalContacts => _totalContacts; // getter method to access the total number of contacts


  Stream<GetContactsOnAppState> getContactsOnApp() async* {
    yield GetContactsOnAppLoading();
    _totalContacts = 0; // Reset total number of contacts to 0
    await repository.contactsOnApp().forEach((result) {
      result.fold(
         (error) => emit(GetContactsOnAppError(error.message)),
         (contactsOnApp) {
            _totalContacts += contactsOnApp.length; // update total number of contacts
            emit(GetContactsOnAppSuccess(contactsOnApp));
          }
      );
    });
  }

}