import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mha_project/screens/tab_screen.dart';

final theme = ThemeData(
  // useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.deepPurpleAccent,
  ),
  // appBarTheme: const AppBarTheme(
  //   iconTheme: IconThemeData(color: Colors.black),
  //   color: Colors.deepPurpleAccent,
  // ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Management Application',
      theme: theme,
      home: const TabScreen(),
    );
  }
}
