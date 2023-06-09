import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:ngandika_app/presentation/bloc/call/call_cubit.dart';
import 'package:ngandika_app/presentation/bloc/main_page/page_cubit.dart';
import 'package:ngandika_app/presentation/bloc/message/bottom_chat/bottom_chat_cubit.dart';
import 'package:ngandika_app/presentation/bloc/message/chat/chat_cubit.dart';
import 'package:ngandika_app/presentation/bloc/message/message_contacts/chat_contacts_cubit.dart';
import 'package:ngandika_app/presentation/bloc/message/message_groups/message_groups_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getAllContact/get_all_contacts_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsNotOnApp/get_contacts_not_on_app_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
import 'package:ngandika_app/presentation/bloc/status/status_cubit.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/cameras/camera_page.dart';
import 'package:ngandika_app/utils/routes/AppRoutes.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import 'firebase_options.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  // Fetch the available cameras before initializing the app.
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(create: (context) => di.locator<AuthCubit>()),
        BlocProvider(
          create: (context) => di.locator<UserCubit>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => di.locator<GetAllContactsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetContactsOnAppCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetContactsNotOnAppCubit>(),
        ),
        BlocProvider(
          create: (context) => BottomChatCubit(),
        ),
        BlocProvider(
          create: (context) => di.locator<ChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<CallCubit>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => di.locator<MessageContactsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MessageGroupsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<StatusCubit>(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.light,
              textTheme: myTextTheme,
              backgroundColor: kPrimaryColor,
              scaffoldBackgroundColor: kPrimaryColor,
              cardColor: kCardLight),
          onGenerateRoute: AppRoutes.onGenerateRoute),
    );
  }
}
