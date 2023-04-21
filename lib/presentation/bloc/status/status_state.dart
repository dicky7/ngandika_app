part of 'status_cubit.dart';

abstract class StatusState extends Equatable {
  const StatusState();
  @override
  List<Object> get props => [];
}

class StatusInitial extends StatusState {}
class StatusLoadingState extends StatusState{}
class StatusErrorState extends StatusState{
  final String message;

  StatusErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class UploadStatusSuccess extends StatusState{}

class GetStatusSuccess extends StatusState{
  final List<StatusModel> statusList;

  GetStatusSuccess(this.statusList);

  @override
  // TODO: implement props
  List<Object> get props => [statusList];
}

