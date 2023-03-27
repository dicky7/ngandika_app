part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState{}

class AuthSuccess extends AuthState{}

class AuthError extends AuthState{
  final String message;

  AuthError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class AuthSetCountrySuccess extends AuthState {
  final Country country;

  AuthSetCountrySuccess(this.country);

  @override
  // TODO: implement props
  List<Object> get props => [country];

}

class AuthCurrentUidLoaded extends AuthState{
  final String userId;

  AuthCurrentUidLoaded(this.userId);

  @override
  // TODO: implement props
  List<Object> get props => [userId];
}