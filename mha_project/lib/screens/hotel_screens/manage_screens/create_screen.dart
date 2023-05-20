import 'package:flutter/material.dart';

class createScreen extends StatelessWidget {
  const createScreen({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CREATE ${categoryName}')),
    );
  }
}
