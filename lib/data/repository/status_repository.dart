import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngandika_app/utils/error/exception.dart';
import 'package:ngandika_app/utils/error/failure.dart';

import '../datasource/status/status_remote_data_source.dart';
import '../models/status_model.dart';

abstract class StatusRepository{
  Future<Either<Failure,void>> uploadStatus({
    required String username,
    required String profilePicture,
    required String phoneNumber,
    required File statusImage,
    required List<String> uidOnAppContact,
    required String caption
  });

  Stream<List<StatusModel>> getStatus();
}
class StatusRepositoryImpl extends StatusRepository{
  final StatusRemoteDataSource remoteDataSource;

  StatusRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> uploadStatus({
    required String username,
    required String profilePicture,
    required String phoneNumber,
    required File statusImage,
    required List<String> uidOnAppContact,
    required String caption
  }) async {
    try{
      final result = await remoteDataSource.uploadStatus(
          username: username,
          profilePicture: profilePicture,
          phoneNumber: phoneNumber,
          statusImage: statusImage,
          uidOnAppContact: uidOnAppContact,
          caption: caption
      );
      return right(result);

    }on ServerException catch(e){
      return left(ServerFailure(e.message));
    }
  }

  @override
  Stream<List<StatusModel>> getStatus() {
    return remoteDataSource.getStatus();
  }

}