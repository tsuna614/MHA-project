import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HMA Application'),
      ),
      body: Column(
        children: [
          Container(
            child: Text('My App'),
          ),
          Text('abc'),
        ],
      ),
    );
  }
}
