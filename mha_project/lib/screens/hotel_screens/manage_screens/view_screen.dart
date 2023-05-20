import 'package:flutter/material.dart';

class viewScreen extends StatelessWidget {
  const viewScreen({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VIEW ${categoryName}')),
    );
  }
}
