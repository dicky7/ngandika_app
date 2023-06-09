import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ngandika_app/data/datasource/auth/auth_local_data_source.dart';
import 'package:ngandika_app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:ngandika_app/data/datasource/call/call_remote_data_source.dart';
import 'package:ngandika_app/data/datasource/chat/chat_remote_data_source.dart';
import 'package:ngandika_app/data/datasource/groups/groups_remote_data_source.dart';
import 'package:ngandika_app/data/datasource/select_contact/select_contact_local_data_source.dart';
import 'package:ngandika_app/data/datasource/select_contact/select_contact_remote_data_source.dart';
import 'package:ngandika_app/data/datasource/status/status_remote_data_source.dart';
import 'package:ngandika_app/data/datasource/user/user_remote_data_source.dart';
import 'package:ngandika_app/data/repository/auth_repository.dart';
import 'package:ngandika_app/data/repository/call_repository.dart';
import 'package:ngandika_app/data/repository/message_contats_repository.dart';
import 'package:ngandika_app/data/repository/chat_repository.dart';
import 'package:ngandika_app/data/repository/message_groups_repository.dart';
import 'package:ngandika_app/data/repository/select_contact_repository.dart';
import 'package:ngandika_app/data/repository/status_repository.dart';
import 'package:ngandika_app/data/repository/user_repository.dart';
import 'package:ngandika_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:ngandika_app/presentation/bloc/call/call_cubit.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';
import 'package:ngandika_app/presentation/bloc/message/message_contacts/chat_contacts_cubit.dart';
import 'package:ngandika_app/presentation/bloc/message/message_groups/message_groups_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getAllContact/get_all_contacts_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsNotOnApp/get_contacts_not_on_app_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
import 'package:ngandika_app/presentation/bloc/status/status_cubit.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/message_contacts/message_contacts_remote_data_source.dart';

final locator = GetIt.instance;

Future<void> init() async {
  /**
   * Cubit
   */
  locator.registerFactory(
    () => AuthCubit(locator()),
  );
  locator.registerFactory(
    () => UserCubit(locator()),
  );
  locator.registerFactory(
    () => GetAllContactsCubit(locator()),
  );
  locator.registerFactory(
    () => GetContactsOnAppCubit(locator()),
  );
  locator.registerFactory(
    () => GetContactsNotOnAppCubit(locator()),
  );
  locator.registerFactory(
        () => MessageGroupsCubit(locator()),
  );
  locator.registerFactory(
    () => ChatCubit(locator()),
  );
  locator.registerFactory(
    () => CallCubit(locator()),
  );
  locator.registerFactory(
    () => MessageContactsCubit(locator()),
  );
  locator.registerFactory(
    () => StatusCubit(locator()),
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
    () => UserRemoteDataSourceImpl(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<SelectContactLocalDataSource>(
    () => SelectContactLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<SelectContactRemoteDataSource>(
    () => SelectContactRemoteDataSourceImpl(locator(), locator()),
  );
  locator.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<CallRemoteDataSource>(
    () => CallRemoteDataSourceImpl(locator(), locator()),
  );
  locator.registerLazySingleton<MessageContactsRemoteDataSource>(
    () => MessageContactsRemoteDataSourceImpl(locator(), locator()),
  );
  locator.registerLazySingleton<StatusRemoteDataSource>(
    () => StatusRemoteDataSourceImpl(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<GroupsRemoteDataSource>(
    () => GroupsRemoteDataSourceImpl(locator(), locator(), locator()),
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
  locator.registerLazySingleton<SelectContactRepository>(
    () => SelectContactRepositoryImpl(locator(), locator()),
  );
  locator.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<CallRepository>(
    () => CallRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<MessageContactsRepository>(
    () => MessageContactsRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<StatusRepository>(
    () => StatusRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<MessageRepository>(
    () => MessageGroupsRepositoryImpl(locator()),
  );


  //External
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);

  ///shared prefs
  final sharedPref = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPref);
}
