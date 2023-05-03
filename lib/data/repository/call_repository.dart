import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:ngandika_app/data/datasource/call/call_remote_data_source.dart';
import 'package:ngandika_app/data/models/call_model.dart';
import 'package:ngandika_app/utils/error/exception.dart';
import 'package:ngandika_app/utils/error/failure.dart';

abstract class CallRepository{
  Stream<CallModel> get callStream;

  Stream<List<CallModel>> getCallHistory();


  Future<Either<Failure, void>> makeCall(BuildContext context,{
    required String receiverId,
    required String receiverName,
    required String receiverPic});

  Future<void> endCall({required String callerId, required String receiverId});
}

class CallRepositoryImpl extends CallRepository{
  final CallRemoteDataSource remoteDataSource;

  CallRepositoryImpl(this.remoteDataSource);

  @override
  Stream<CallModel> get callStream => remoteDataSource.callStream;

  @override
  Stream<List<CallModel>> getCallHistory() => remoteDataSource.getCallHistory();

  @override
  Future<Either<Failure, void>> makeCall(BuildContext context,{
    required String receiverId,
    required String receiverName,
    required String receiverPic
  }) async {
    try{
      final result = await remoteDataSource.makeCall(
          context,
          receiverId: receiverId,
          receiverName: receiverName,
          receiverPic: receiverPic);
      return right(result);

    }on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<void> endCall({required String callerId, required String receiverId}) {
    return remoteDataSource.endCall(callerId: callerId, receiverId: receiverId);
  }


}
