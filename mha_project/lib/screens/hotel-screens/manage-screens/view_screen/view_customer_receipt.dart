import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewReceipt extends StatefulWidget {
  const ViewReceipt({super.key});

  @override
  State<ViewReceipt> createState() => _ViewReceiptState();
}

class _ViewReceiptState extends State<ViewReceipt> {
  final user = FirebaseAuth.instance.currentUser!;
  final firestoreRef = FirebaseFirestore.instance;
  void viewReceiptCard() async {
    List<String> bookingCustomerId = [];
    List<String> addServiceCustomerId = [];
    await firestoreRef
        .collection('booking')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        String idOfCustomer = doc['customerId'];
        bookingCustomerId.add(idOfCustomer);
      });
    });
    await firestoreRef
        .collection('add_service')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        String idOfCustomerSerVice = doc['guestId'];
        addServiceCustomerId.add(idOfCustomerSerVice);
      });
    });
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
          children: [],
        ),
      ),
    );
  }
}
