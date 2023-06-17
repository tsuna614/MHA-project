import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/view_screen/receipt_booking_card.dart';

class ViewReceipt extends StatefulWidget {
  const ViewReceipt(
      {super.key,
      required this.customerId,
      required this.customerName,
      required this.customerType});
  final String customerId, customerName, customerType;

  @override
  State<ViewReceipt> createState() => _ViewReceiptState();
}

class _ViewReceiptState extends State<ViewReceipt> {
  final user = FirebaseAuth.instance.currentUser!;
  final firestoreRef = FirebaseFirestore.instance;
  List<Widget> receiptsBookingCards = [];
  void viewReceiptCard() async {
    // print(widget.customerId);
    await firestoreRef
        .collection('booking')
        .where('customerId', isEqualTo: widget.customerId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        receiptsBookingCards.add(ReceiptBookingCard(
            customerName: widget.customerName,
            customerType: widget.customerType,
            guestId: doc['customerId'],
            dateArrival: doc['arrival'],
            dateDeparture: doc['departure'],
            roomPrice: doc['price'],
            roomType: doc['type'],
            userId: doc['userId'],
            docId: doc.id));
      });
    });
    // await firestoreRef
    //     .collection('add_service')
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((doc) {
    //     String idOfCustomerSerVice = doc['guestId'];
    //     addServiceCustomerId.add(idOfCustomerSerVice);
    //   });
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewReceiptCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RECEIPTS'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: receiptsBookingCards,
        ),
      ),
    );
  }
}
