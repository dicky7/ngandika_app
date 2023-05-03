import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:ngandika_app/data/models/call_model.dart';

import '../../../data/repository/call_repository.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final CallRepository repository;

  CallCubit(this.repository) : super(CallInitial());

  Stream<CallModel> get callStream => repository.callStream;

  Stream<List<CallModel>> getCallHistory() => repository.getCallHistory();

  Future<void> makeCall(BuildContext context,{
    required String receiverId,
    required String receiverName,
    required String receiverPic,
    required bool isGroupChat
  }) async{
    final result = await repository.makeCall(
        context,
        receiverId: receiverId,
        receiverName: receiverName,
        receiverPic: receiverPic
    );
    result.fold(
      (l) => emit(CallError(l.message)),
      (r) => emit(MakeCallSuccess()),
    );
  }

  Future<void> endCall({required String callerId, required String receiverId}){
    return repository.endCall(callerId: callerId, receiverId: receiverId);
  }
}
