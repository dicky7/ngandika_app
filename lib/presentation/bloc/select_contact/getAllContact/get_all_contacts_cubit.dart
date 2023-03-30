

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getAllContact/get_all_contacts_state.dart';

import '../../../../data/repository/select_contact_repository.dart';

class GetAllContactsCubit extends Cubit<GetAllContactsState> {
  final SelectContactRepository repository;
  
  GetAllContactsCubit(this.repository) : super(GetAllContactstInitial());

  int _totalContacts = 0; // class-level variable to store the total number of contacts
  int get totalContacts => _totalContacts; // getter method to access the total number of contacts

  static GetAllContactsCubit get(context) => BlocProvider.of(context);


  Future<void> getAllContacts() async{
    emit(GetAllContactsLoading());
    _totalContacts = 0; // Reset total number of contacts to 0
    final result = await repository.getAllContacts();
    result.fold(
      (error) => emit(GetAllContactsError(error.message)),
      (contact) {
        emit(GetAllContactsSuccess());
      },
    );
  }





}
