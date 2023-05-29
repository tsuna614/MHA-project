import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/view_screen/view_card.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/view_screen/view_room.dart';

final firestoreRef = FirebaseFirestore.instance;

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    double AppbarHeight = AppBar().preferredSize.height;
    double ScreenHeight = MediaQuery.of(context).size.height;
    double showBottomSheetHeight = ScreenHeight - AppbarHeight;
    print(ScreenHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text('VIEW $categoryName'.toUpperCase()),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
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
                final docId = loadedData[index].id;
                return Column(
                  children: [
                    ViewCard(
                      address: data['address'],
                      beds: data['beds'],
                      floor: data['floor'],
                      price: data['price'],
                      type: data['type'],
                      showBottomSheetHeight: showBottomSheetHeight,
                      userId: data['userId'],
                      docId: docId,
                    )
                  ],
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