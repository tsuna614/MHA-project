import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/view_screen/view_card.dart';

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
        stream: firestoreRef.collection('$categoryName').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return Center(
              child: Text('No $categoryName found.'),
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
                    if (categoryName == 'room') ...[
                      ViewCard(
                          categoryName: categoryName,
                          parameter1: data['address'],
                          parameter2: data['floor'],
                          parameter3: data['type'],
                          parameter4: data['beds'],
                          parameter5: data['price'],
                          showBottomSheetHeight: showBottomSheetHeight,
                          userId: data['userId'],
                          docId: docId)
                    ] else if (categoryName == 'service') ...[
                      ViewCard(
                          categoryName: categoryName,
                          parameter1: data['id'],
                          parameter2: data['name'],
                          parameter3: data['type'],
                          parameter4: data['number'],
                          parameter5: data['price'],
                          showBottomSheetHeight: showBottomSheetHeight,
                          userId: data['userId'],
                          docId: docId)
                    ] else ...[
                      ViewCard(
                          categoryName: categoryName,
                          parameter1: data['id'],
                          parameter2: data['name'],
                          parameter3: data['email'],
                          parameter4: data['number'],
                          parameter5: 'None',
                          showBottomSheetHeight: showBottomSheetHeight,
                          userId: data['userId'],
                          docId: docId)
                    ]
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