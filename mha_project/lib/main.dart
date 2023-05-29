import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mha_project/screens/loading_screen.dart';
import 'package:mha_project/screens/main_screen.dart';
import 'firebase_options.dart';

import 'package:mha_project/screens/auth_screen.dart';
import 'package:mha_project/screens/hotel_tabs_screen.dart';

// final theme = ThemeData(
//   // useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     brightness: Brightness.light,
//     seedColor: Color.fromARGB(255, 15, 99, 255),
//   ),
//   // appBarTheme: const AppBarTheme(
//   //   iconTheme: IconThemeData(color: Colors.black),
//   //   color: Colors.deepPurpleAccent,
//   // ),
//   // primaryColor: Color.fromARGB(255, 255, 154, 38),
//   textTheme: GoogleFonts.latoTextTheme(),
// );

final theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color.fromARGB(255, 255, 123, 29),

  // fontFamily: 'Georgia',
  // textTheme: const TextTheme(
  //   displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  //   titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  //   bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  // ),

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
        debugShowCheckedModeBanner: false,
        title: 'Hotel Management Application',
        theme: theme,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              }
              if (snapshot.hasData) {
                return const MainScreen();
              }
              return const AuthScreen();
            }));
  }
}
