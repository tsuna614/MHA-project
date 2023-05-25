import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestoreRef = FirebaseFirestore.instance;

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VIEW $categoryName'.toUpperCase())),
      body: StreamBuilder(
        stream: firestoreRef.collection('room').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text('No rooms found.'),
            );
          }

          if (snapshots.hasError) {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }

          final loadedData = snapshots.data!.docs;

          return ListView.builder(
              itemCount: loadedData.length,
              itemBuilder: (context, index) {
                final data = loadedData[index].data();
                return Column(
                  children: [Text(data['address']), Text(data['price'])],
                );
              });
        },
      ),
    );
  }
}

// Future<void> _ViewScreen() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   ViewScreen(categoryName: categoryName);
// }