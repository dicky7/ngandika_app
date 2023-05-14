import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngandika_app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:ngandika_app/utils/error/exception.dart';
import 'package:ngandika_app/utils/error/failure.dart';

import '../datasource/auth/auth_local_data_source.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signInWithNumber(String phoneNumber);

  Future<Either<Failure, void>> verifyOtp(String smsOtpCode);

  Future<Either<Failure, void>> saveUserDataToFirebase(String username, File? profilePicture);

  Future<String> getCurrentUid();

  Future<void> signOut();
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource, this.authLocalDataSource);

  //this method returns an Either instance, indicating success or failure of the sign-in operation,
  // and it handles both expected and unexpected errors.
  @override
  Future<Either<Failure, void>> signInWithNumber(String phoneNumber) async {
    try {
      //It calls the remoteDataSource.signInWithPhone() method, passing in the phoneNumber. If the operation is successful,
      // it returns a Right instance wrapping the result value.
      final result = await authRemoteDataSource.signInWithPhone(phoneNumber);
      return Right(result);

      //If the remoteDataSource.signIn() call throws a ServerException, it catches the exception and returns a Left instance wrapping
      // a ServerFailure instance with an message.
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(String smsOtpCode) async {
    try {
      final result = await authRemoteDataSource.verifyOtp(smsOtpCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserDataToFirebase(
      String username, File? profilePicture) async {
    try {
      final result = await authRemoteDataSource.saveUserDataToFirebase(
          username, profilePicture);

      //when saveUserDataToFirebase is successful, it wil save the currentUid to shared pref
      authLocalDataSource.setUserId(await authRemoteDataSource.getCurrentUid());

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<String> getCurrentUid() async {
    final result = await authLocalDataSource.getUserId();
    return result;
  }

  @override
  Future<void> signOut() async {
    await authRemoteDataSource.signOut();
    await authLocalDataSource.removeUserId();
  }
}
