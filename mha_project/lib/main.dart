import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mha_project/screens/loading_screen.dart';
import 'firebase_options.dart';

import 'package:mha_project/screens/auth_screen.dart';
import 'package:mha_project/screens/hotel_screens/tabs_screen.dart';

final theme = ThemeData(
  // useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 115, 0, 255),
  ),
  // appBarTheme: const AppBarTheme(
  //   iconTheme: IconThemeData(color: Colors.black),
  //   color: Colors.deepPurpleAccent,
  // ),
  // primaryColor: Color.fromARGB(255, 255, 154, 38),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hotel Management Application',
        theme: theme,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              }
              if (snapshot.hasData) {
                return const TabScreen();
              }
              return const AuthScreen();
            }));
  }
}
