import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngandika_app/data/datasource/user/user_remote_data_source.dart';
import 'package:ngandika_app/utils/error/failure.dart';

import '../models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline);
}

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<Either<Failure, UserModel>> getCurrentUserData() async {
    try {
      final result = await userRemoteDataSource.getCurrentUserData();
      return Right(result!);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Stream<UserModel> getUserById(String id) {
    return userRemoteDataSource.getUserById(id);
  }

  @override
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline) async{
    try{
      final result = await userRemoteDataSource.setUserStateStatus(isOnline);
      return Right(result);
    } on FirebaseAuthException catch(e){
      return Left(ServerFailure(e.message!));
    }
  }
}
