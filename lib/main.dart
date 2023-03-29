import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:ngandika_app/presentation/bloc/main_page/page_cubit.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/select_contact_cubit.dart';
import 'package:ngandika_app/presentation/bloc/user/user_cubit.dart';
import 'package:ngandika_app/presentation/pages/main/main_page.dart';
import 'package:ngandika_app/utils/routes/AppRoutes.dart';
import 'package:ngandika_app/utils/styles/style.dart';
import 'firebase_options.dart';

import 'injection.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
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
        BlocProvider(
          create: (context) => di.locator<AuthCubit>()
        ),
        BlocProvider(
          create: (context) => di.locator<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SelectContactCubit>(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: myTextTheme,
          backgroundColor: kPrimaryColor,
          scaffoldBackgroundColor: kPrimaryColor,
          cardColor: kCardLight
        ),
        onGenerateRoute: AppRoutes.onGenerateRoute

      ),
    );
  }
}
