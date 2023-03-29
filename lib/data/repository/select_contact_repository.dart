import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:ngandika_app/data/datasource/select_contact/select_contact_local_data_source.dart';
import 'package:ngandika_app/utils/error/exception.dart';
import 'package:ngandika_app/utils/error/failure.dart';

import '../datasource/select_contact/select_contact_remote_data_source.dart';

abstract class SelectContactRepository{
  Future<Either<Failure, void>> getAllContacts();
  Future<Either<Failure, Map<String, dynamic>>> contactsOnApp();
  Future<Either<Failure, List<Contact>>> contactsNotOnApp();
}
class SelectContactRepositoryImpl extends SelectContactRepository{
  final SelectContactRemoteDataSource remoteDataSource;
  final SelectContactLocalDataSource localDataSource;

  SelectContactRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, void>> getAllContacts() async{
    try{
      //The method first calls the localDataSource.getContactLocal() method to retrieve a list of contacts available on the user's device.
      // It then passes this list as an argument to the remoteDataSource.getAllContacts() method to retrieve the contacts available on the remote database
      // that match the phone numbers in the user's local contacts.
      final result = await remoteDataSource.getAllContacts(await localDataSource.getContactLocal());
      return Right(result);
    }on DatabaseException catch(e){
      return Left(ServerFailure("repository getAllContacts DatabaseException${e.message}"));
    }on ServerException catch(e){
      return Left(ServerFailure("repository getAllContacts ServerException${e.message}"));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> contactsNotOnApp() async{
    try{
      final result = await remoteDataSource.contactsNotOnApp();
      return Right(result);
    }on ServerException catch (e){
      return Left(ServerFailure("repository contactsNotOnApp${e.message}"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> contactsOnApp() async{
    try{
      final result = await remoteDataSource.contactsOnApp();
      return Right(result);
    }on ServerException catch (e){
      return Left(ServerFailure("repository contactsOnApp${e.message}"));
    }
  }

}