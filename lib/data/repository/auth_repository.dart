import 'package:dartz/dartz.dart';
import 'package:ngandika_app/data/datasource/auth_remote_data_source.dart';
import 'package:ngandika_app/utils/error/exception.dart';
import 'package:ngandika_app/utils/error/failure.dart';

abstract class AuthRepository{
  Future<Either<Failure, void>> signInWithNumber(String phoneNumber);
  Future<Either<Failure, void>> verifyOtp(String smsOtpCode);
}

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  //this method returns an Either instance, indicating success or failure of the sign-in operation,
  // and it handles both expected and unexpected errors.
  @override
  Future<Either<Failure, void>> signInWithNumber(String phoneNumber) async{
    try{
      //It calls the remoteDataSource.signInWithPhone() method, passing in the phoneNumber. If the operation is successful,
      // it returns a Right instance wrapping the result value.
      final result = await authRemoteDataSource.signInWithPhone(phoneNumber);
      return Right(result);

      //If the remoteDataSource.signIn() call throws a ServerException, it catches the exception and returns a Left instance wrapping
      // a ServerFailure instance with an message.
    }on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(String smsOtpCode) async{
    try{
      final result = await authRemoteDataSource.verifyOtp(smsOtpCode);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }
  }
}