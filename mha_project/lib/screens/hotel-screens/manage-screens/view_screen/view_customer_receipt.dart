import 'package:cloud_firestore/cloud_firestore.dart';
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

  bool isExist = true;

  List<Widget> receiptsBookingCards = [];

  void viewReceiptCard() async {
    // print(widget.customerId);
    await firestoreRef
        .collection('booking')
        .where('customerId', isEqualTo: widget.customerId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          // print('---------------------');
          // print(receiptsBookingCards);
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
    });
    if (receiptsBookingCards.isEmpty) {
      setState(() {
        isExist = false;
      });
    }
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          child: isExist
              ? ListView.builder(
                  itemCount: receiptsBookingCards.length,
                  itemBuilder: ((context, index) {
                    return receiptsBookingCards[index];
                  }),
                )
              : Center(
                  child: Text(
                      'Sorry, no receipt found. Please book a room and try again.'),
                )),
    );
  }
}
