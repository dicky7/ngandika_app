import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:ngandika_app/data/datasource/auth_remote_data_source.dart';
import 'package:ngandika_app/data/repository/auth_repository.dart';
import 'package:ngandika_app/presentation/bloc/auth/auth_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async{
  //Cubit
  locator.registerFactory(
    () => AuthCubit(locator()),
  );

  //Data Source
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(locator(), locator()),
  );

  //Repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator()),
  );

  //External
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}