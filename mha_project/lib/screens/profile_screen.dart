import 'package:flutter/material.dart';
import 'package:mha_project/widgets/my_flutter_app_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [IconButton(onPressed: () {}, icon: Icon(MyFlutterApp.edit))],
      ),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}
