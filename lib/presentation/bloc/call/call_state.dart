part of 'call_cubit.dart';

abstract class CallState extends Equatable {
  const CallState();
  @override
  List<Object> get props => [];
}

class CallInitial extends CallState {}
class CallError extends CallState {
  final String message;

  CallError(this.message);

  @override
  List<Object> get props => [message];
}

class MakeCallSuccess extends CallState {}


