import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firestoreRef = FirebaseFirestore.instance;
// final user = FirebaseAuth.instance.currentUser!;

class InfoCard extends StatefulWidget {
  const InfoCard({super.key});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  var numberOfRooms = 0;
  var numberOfServices = 0;
  var numberOfEmployees = 0;
  var numberOfCustomers = 0;
  void getInfoDetails() async {
    final user = FirebaseAuth.instance.currentUser!;
    print(user.uid);
    // get number of rooms
    await firestoreRef
        .collection('room')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          numberOfRooms++;
        });
      });
    });
    // get number of services
    await firestoreRef
        .collection('service')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          numberOfServices++;
        });
      });
    });
    // get number of employees
    await firestoreRef
        .collection('employee')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          numberOfEmployees++;
        });
      });
    });
    // get number of customers
    await firestoreRef
        .collection('customer')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          numberOfCustomers++;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfoDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 100),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Room',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 2),
                Text(
                  numberOfRooms.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 89, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Service',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 2),
                Text(
                  numberOfServices.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 89, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Employee',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 2),
                Text(
                  numberOfEmployees.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 89, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Guest',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 2),
                Text(
                  numberOfCustomers.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 89, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
