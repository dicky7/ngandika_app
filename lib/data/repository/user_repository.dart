import 'package:dartz/dartz.dart';
import 'package:ngandika_app/data/datasource/user/user_remote_data_source.dart';
import 'package:ngandika_app/utils/error/failure.dart';

import '../models/user_model.dart';

abstract class UserRepository{
  Future<Either<Failure, UserModel>> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
}
class UserRepositoryImpl extends UserRepository{
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<Either<Failure, UserModel>> getCurrentUserData() async{
    try{
      final result = await userRemoteDataSource.getCurrentUserData();
      return Right(result!);

    }on ServerFailure catch(e){
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Stream<UserModel> getUserById(String id) {
    return userRemoteDataSource.getUserById(id);
  }

}