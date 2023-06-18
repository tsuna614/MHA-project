import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/booking-screen/booking_card.dart';

class FindRoomScreen extends StatefulWidget {
  FindRoomScreen(
      {super.key,
      required this.roomIdList,
      required this.guestId,
      required this.dateArrival,
      required this.dateDeparture,
      required this.roomPrice,
      required this.roomType});
  final List<String> roomIdList;
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

  bool isExist = true;

  StreamSubscription? _roomStreamSub;

  void viewCard() async {
    if (widget.roomIdList.isEmpty) {
      isExist = false;
      return;
    }

    _roomStreamSub?.cancel();
    _roomStreamSub = firestoreRef
        .collection('room')
        .where(FieldPath.documentId, whereIn: widget.roomIdList)
        .snapshots()
        .listen((querySnapshot) {
      setState(() {
        bookingCards = querySnapshot.docs.map((docSnapshot) {
          final docJson = docSnapshot.data();
          return BookingCard(
            roomAddress: docJson['address'],
            roomPrice: int.parse(docJson['price']),
            roomType: docJson['type'],
            dateArrival: widget.dateArrival,
            dateDeparture: widget.dateDeparture,
            guestId: widget.guestId,
            userId: docJson['userId'],
            docId: docSnapshot.id,
          );
        }).toList();
      });
    });

    // for (var i = 0; i < widget.roomIdList.length; i++) {
    //   firestoreRef
    //       .collection('room')
    //       .doc(widget.roomIdList[i])
    //       .snapshots()
    //       .listen((doc) {
    //     if (doc.exists) {
    //       setState(() {
    //         final docJson = doc.data();
    //         // print(doc['address']);
    //         // print(int.parse(doc['price']));
    //         // print(doc['type']);
    //         // print(widget.dateArrival);
    //         // print(widget.dateDeparture);
    //         // print(widget.guestId);
    //         // print(doc['userId']);
    //         // print(doc.id);
    //         bookingCards.add(BookingCard(
    //             roomAddress: docJson['address'],
    //             roomPrice: int.parse(docJson['price']),
    //             roomType: docJson['type'],
    //             dateArrival: widget.dateArrival,
    //             dateDeparture: widget.dateDeparture,
    //             guestId: widget.guestId,
    //             userId: docJson['userId'],
    //             docId: docJson.id));
    //       });
    //     } else if (!doc.exists) {
    //       print('Document not exit');
    //     }
    //   });
    //   // firestoreRef
    //   //     .collection('room')
    //   //     .where(, isEqualTo: roomId[i])
    //   //     .get()
    //   //     .then((QuerySnapshot snapshot) {
    //   //   snapshot.docs.forEach((doc) {
    //   // bookingCards.add(BookingCard(
    //   //     parameter1: doc['address'],
    //   //     parameter2: doc['floor'],
    //   //     parameter3: doc['type'],
    //   //     parameter4: doc['beds'],
    //   //     parameter5: doc['price'],
    //   //     userId: doc['userId'],
    //   //     docId: doc.id));
    //   //   });
    //   // });
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewCard();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _roomStreamSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ROOMS'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Container(
          child: isExist
              ? ListView(
                  children: bookingCards,
                )
              : Center(
                  child: Text(
                      'Sorry, no room is available. Please try a different date.'),
                )),
    );
  }
}
