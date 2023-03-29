

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/select_contact_state.dart';

import '../../../data/repository/select_contact_repository.dart';

class SelectContactCubit extends Cubit<SelectContactState> {
  final SelectContactRepository repository;
  
  SelectContactCubit(this.repository) : super(SelectContactInitial());

  int _totalContacts = 0; // class-level variable to store the total number of contacts
  int get totalContacts => _totalContacts; // getter method to access the total number of contacts

  static SelectContactCubit get(context) => BlocProvider.of(context);


  Future<void> getAllContacts() async{
    emit(SelectContactLoadingState());
    final result = await repository.getAllContacts();
    result.fold(
      (error) => emit(SelectContactErrorState(error.message)),
      (contact) {
        emit(GetAllContactsSuccess());
      },
    );
  }

  Future<void> getContactsNotOnApp() async{
    emit(SelectContactLoadingState());
    final result = await repository.contactsNotOnApp();
    result.fold(
      (error) => emit(SelectContactErrorState(error.message)),
      (contactsNotOnApp) {
        _totalContacts += contactsNotOnApp.length; // update total number of contacts
        emit(GetContactsNotOnAppSuccess(contactsNotOnApp));
      }
    );
  }

  Future<void> getContactsOnApp() async{
    emit(SelectContactLoadingState());
    final result = await repository.contactsOnApp();
    result.fold(
      (error) => emit(SelectContactErrorState(error.message)),
      (contactsOnApp) {
        _totalContacts += contactsOnApp.length; // update total number of contacts
        emit(GetContactsOnAppSuccess(contactsOnApp));
      }
    );
  }

  ///////////
  List<Contact> contactNotOnWhats=[];

  Future<void> getContactsNotOnWhatsApp() async {
    emit(SelectContactLoadingState());
    contactNotOnWhats = [];
    final result = await repository.contactsNotOnApp();
    result.fold(
          (error) => emit(SelectContactErrorState(error.message)),
          (r) {
        for (var element in r) {
          contactNotOnWhats.add(element);
        }
        emit(GetContactsNotOnWhatsSuccessState());
      } ,
    );
  }

////////////
  Map<String,dynamic> contactOnWhats={};
  Future<void> getContactsOnWhatsApp() async {
    emit(SelectContactLoadingState());
    //contactOnWhats = {};
    final result = await repository.contactsOnApp();
    result.fold(
          (error) => emit(SelectContactErrorState(error.message)),
          (r) {
        contactOnWhats.addAll(r);
        emit(GetContactsOnWhatsSuccessState());
      },
    );
  }

}
