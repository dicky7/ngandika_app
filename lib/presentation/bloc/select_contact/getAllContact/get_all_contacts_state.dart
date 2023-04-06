import 'package:equatable/equatable.dart';

abstract class GetAllContactsState extends Equatable {
  const GetAllContactsState();

  @override
  List<Object> get props => [];
}

class GetAllContactstInitial extends GetAllContactsState {}

/**
 * GetAllContacts
 */
class GetAllContactsLoading extends GetAllContactsState {}

class GetAllContactsSuccess extends GetAllContactsState {}

class GetAllContactsError extends GetAllContactsState {
  final String message;

  GetAllContactsError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
