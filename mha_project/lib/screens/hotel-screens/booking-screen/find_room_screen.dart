import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/booking-screen/booking_card.dart';

class FindRoomScreen extends StatefulWidget {
  FindRoomScreen({super.key, required this.roomId});
  final List<String> roomId;

  @override
  State<FindRoomScreen> createState() => _FindRoomScreenState();
}

class _FindRoomScreenState extends State<FindRoomScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  final firestoreRef = FirebaseFirestore.instance;

  List<Widget> bookingCards = [];

  void viewCard() async {
    for (var i = 0; i < widget.roomId.length; i++) {
      final doc_id = await firestoreRef
          .collection('room')
          .doc(widget.roomId[i])
          .snapshots()
          .listen((doc_id) {
        if (doc_id.exists) {
          setState(() {
            bookingCards.add(BookingCard(
                parameter1: doc_id['address'],
                parameter2: doc_id['floor'],
                parameter3: doc_id['type'],
                parameter4: doc_id['beds'],
                parameter5: doc_id['price'],
                userId: doc_id['userId'],
                docId: doc_id.id));
            print(bookingCards);
          });
        } else if (!doc_id.exists) {
          print('Document not exit');
        }
      });
      // firestoreRef
      //     .collection('room')
      //     .where(, isEqualTo: roomId[i])
      //     .get()
      //     .then((QuerySnapshot snapshot) {
      //   snapshot.docs.forEach((doc) {
      // bookingCards.add(BookingCard(
      //     parameter1: doc['address'],
      //     parameter2: doc['floor'],
      //     parameter3: doc['type'],
      //     parameter4: doc['beds'],
      //     parameter5: doc['price'],
      //     userId: doc['userId'],
      //     docId: doc.id));
      //   });
      // });
    }
    print(widget.roomId.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewCard();
  }

  @override
  Widget build(BuildContext context) {
    final userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('ROOMS'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: bookingCards,
        ),
      ),
    );
    // body: ElevatedButton(
    //   onPressed: () {
    //     viewCard();
    //   },
    //   child: const Text('aaaa'),
    // ));
  }
}
