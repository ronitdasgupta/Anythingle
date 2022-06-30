import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/constant/colors.dart';
import 'package:summerapp/models/user.dart';
import 'package:summerapp/screens/wrapper.dart';
import 'package:summerapp/services/auth.dart';
import 'package:summerapp/services/puzzlesCollection.dart';

import 'models/controller.dart';
import 'models/puzzleInfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      StreamProvider<MyUser?>.value(
        value: AuthService().user,
        initialData: null,
      ),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColorLight: lightThemeLightShade,
          primaryColorDark: lightThemeDarkShade,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme().copyWith(
            bodyText2: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        home: Wrapper(),
      );
  }
}
