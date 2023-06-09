import 'package:bloc/bloc.dart';

import '../../../../data/repository/select_contact_repository.dart';
import 'get_contacts_on_app_state.dart';

class GetContactsOnAppCubit extends Cubit<GetContactsOnAppState> {
  final SelectContactRepository repository;

  GetContactsOnAppCubit(this.repository) : super(GetContactsOnAppInitial());

  int _totalContacts =
      0; // class-level variable to store the total number of contacts
  int get totalContacts => _totalContacts; // getter method to access the total number of contacts

  Map<String, dynamic> _contactsOnApp = {};

  Map<String, dynamic> get contactsOnApp => _contactsOnApp;

  List<String> _contactUid = [];

  List<String> get contactUid => _contactUid; // to fetch user id on app for upload status


  Future<void> getContactsOnApp() async {
    emit(GetContactsOnAppLoading());
    _totalContacts = 0; // Reset total number of contacts to 0
    final result = await repository.contactsOnApp();
    result.fold((error) => emit(GetContactsOnAppError(error.message)),
        (success) {
      _totalContacts += success.length; // update total number of contacts
      _contactsOnApp.addAll(success);

      // Extract uIds from success and store in _contactUid
      _contactUid = success.values.map((value) => value['uId'] as String).toList();

      emit(GetContactsOnAppSuccess());
    });
  }
}
