import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestoreRef = FirebaseFirestore.instance;

class viewScreen extends StatelessWidget {
  const viewScreen({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VIEW ${categoryName}'.toUpperCase())),
      // body: StreamBuilder(stream: firestoreRef.collection('room'),),
    );
  }
}
