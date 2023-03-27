import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ngandika_app/data/datasource/auth/auth_local_data_source.dart';
import 'package:ngandika_app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:ngandika_app/data/datasource/user/user_remote_data_source.dart';
import 'package:ngandika_app/data/repository/auth_repository.dart';
import 'package:ngandika_app/data/repository/user_repository.dart';
import 'package:ngandika_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async{
  /**
   * Cubit
   */
  locator.registerFactory(
    () => AuthCubit(locator()),
  );
  locator.registerFactory(
    () => UserCubit(locator()),
  );


  /**
   * Data Source
   */
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(locator(), locator()),
  );

  /**
   * Repository
   */
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator(), locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(locator()),
  );

  //External
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  ///shared prefs
  final sharedPref = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPref);
}