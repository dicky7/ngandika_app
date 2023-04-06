import 'package:equatable/equatable.dart';

abstract class GetContactsOnAppState extends Equatable {
  const GetContactsOnAppState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetContactsOnAppInitial extends GetContactsOnAppState {}

class GetContactsOnAppLoading extends GetContactsOnAppState {}

class GetContactsOnAppSuccess extends GetContactsOnAppState {}

class GetContactsOnAppError extends GetContactsOnAppState {
  final String message;

  GetContactsOnAppError(this.message);

  @override
  List<Object> get props => [message];
}
