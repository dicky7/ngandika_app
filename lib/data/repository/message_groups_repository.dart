import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngandika_app/data/datasource/groups/groups_remote_data_source.dart';
import 'package:ngandika_app/data/models/group_model.dart';
import 'package:ngandika_app/utils/error/failure.dart';

import '../../utils/error/exception.dart';

abstract class MessageRepository{
  Future<Either<Failure, void>> createGroup(String name, File profilePicture, List<String> selectedUidContact);
  Stream<List<GroupModel>> getChatGroups();
  Stream<int> getNumOfMessageNotSeen(String senderId);
}
class MessageGroupsRepositoryImpl extends MessageRepository{
  final GroupsRemoteDataSource remoteDataSource;

  MessageGroupsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> createGroup(
      String name, File profilePicture, List<String> selectedUidContact) async{
    try{
      final result = await remoteDataSource.createGroup(name, profilePicture, selectedUidContact);
      return right(result);
    }on ServerException catch(e){
      return left(ServerFailure(e.message));
    }
  }

  @override
  Stream<List<GroupModel>> getChatGroups() {
    return remoteDataSource.getChatGroups();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    // TODO: implement getNumOfMessageNotSeen
    throw UnimplementedError();
  }

}