import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status_model.dart';
import '../../../data/repository/status_repository.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  final StatusRepository repository;

  StatusCubit(this.repository) : super(StatusInitial());

  Future<void> addStatus({
    required String username,
    required String profilePicture,
    required String phoneNumber,
    required File statusImage,
    required List<String> uidOnAppContact,
    required String caption
  })async{
    emit(StatusLoadingState());
    final result = await repository.uploadStatus(
        username: username,
        profilePicture: profilePicture,
        phoneNumber: phoneNumber,
        statusImage: statusImage,
        uidOnAppContact: uidOnAppContact,
        caption: caption
    );
    result.fold(
      (error) => emit(StatusErrorState(error.message)),
      (success) => emit(UploadStatusSuccess()),
    );
  }

  Stream<List<StatusModel>> getStatus() {
    return repository.getStatus();
  }

}
