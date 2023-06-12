import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/booking-screen/booking_card.dart';

class FindRoomScreen extends StatefulWidget {
  FindRoomScreen(
      {super.key,
      required this.roomId,
      required this.guestId,
      required this.dateArrival,
      required this.dateDeparture,
      required this.roomPrice,
      required this.roomType});
  final List<String> roomId;
  final String guestId;
  final Timestamp dateArrival, dateDeparture;
  final int roomPrice;
  final String roomType;
  @override
  State<FindRoomScreen> createState() => _FindRoomScreenState();
}

class _FindRoomScreenState extends State<FindRoomScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  final firestoreRef = FirebaseFirestore.instance;

  List<Widget> bookingCards = [];

  void viewCard() async {
    for (var i = 0; i < widget.roomId.length; i++) {
      await firestoreRef
          .collection('room')
          .doc(widget.roomId[i])
          .snapshots()
          .listen((doc_id) {
        if (doc_id.exists) {
          setState(() {
            bookingCards.add(BookingCard(
                roomAddress: doc_id['address'],
                roomPrice: int.parse(doc_id['price']),
                roomType: doc_id['type'],
                dateArrival: widget.dateArrival,
                dateDeparture: widget.dateDeparture,
                guestId: widget.guestId,
                userId: doc_id['userId'],
                docId: doc_id.id));
            print(bookingCards);
            print(doc_id['address']);
            print(doc_id['type']);
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
