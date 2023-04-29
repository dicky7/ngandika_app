import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngandika_app/data/datasource/groups/groups_remote_data_source.dart';
import 'package:ngandika_app/utils/error/failure.dart';

import '../../utils/error/exception.dart';

abstract class GroupsRepository{
  Future<Either<Failure, void>> createGroup(String name, File profilePicture, List<String> selectedUidContact);
}
class GroupsRepositoryImpl extends GroupsRepository{
  final GroupsRemoteDataSource remoteDataSource;

  GroupsRepositoryImpl(this.remoteDataSource);

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

}