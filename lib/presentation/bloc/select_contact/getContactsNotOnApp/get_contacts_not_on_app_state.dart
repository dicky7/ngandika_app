part of 'get_contacts_not_on_app_cubit.dart';

abstract class GetContactsNotOnAppState extends Equatable {
  const GetContactsNotOnAppState();
  @override
  List<Object> get props => [];
}



class GetContactsNotOnAppInitial extends GetContactsNotOnAppState {}

/**
 * GetContactsNotOnApp
 */
class GetContactsNotOnAppLoading extends GetContactsNotOnAppState{}
class GetContactsNotOnAppSuccess extends GetContactsNotOnAppState {
  final List<Contact> contactsNotOnApp;

  GetContactsNotOnAppSuccess(this.contactsNotOnApp);

  @override
  // TODO: implement props
  List<Object> get props => [contactsNotOnApp];
}
class GetContactsNotOnAppError extends GetContactsNotOnAppState{
  final String message;

  GetContactsNotOnAppError(this.message);

  @override
  List<Object> get props => [message];
}
