import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firestoreRef = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser!;

class ReportCard extends StatefulWidget {
  const ReportCard({
    super.key,
    required this.cardColor,
    required this.cardType,
  });

  final Color cardColor;
  final String cardType;

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  var numberOfIncome = 0.0;
  var numberOfRevenue;
  var numberOfOccupancy;
  var numberOfGuests;

  // bool isBookingToday() {}

  void getReportData() {
    firestoreRef
        .collection('booking')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc['bookingDate'].isDateEqual(DateTime.now())) {
          numberOfIncome += double.parse(doc['price']);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData reportCardIcon = Icons.error;
    var titleText = '';
    var mainText = '';

    void getType() {
      switch (widget.cardType) {
        case 'income':
          reportCardIcon = Icons.monetization_on_outlined;
          titleText = 'Today\'s income';
          mainText = numberOfIncome.toString();
          break;
        case 'revenue':
          reportCardIcon = Icons.meeting_room_outlined;
          titleText = 'Avg. revenue/room';
          mainText = '156.00';
          break;
        case 'occupancy':
          reportCardIcon = Icons.bed_outlined;
          titleText = 'Occupancy rate';
          mainText = '6.00';
          break;
        case 'guest':
          reportCardIcon = Icons.people;
          titleText = 'In-house groups';
          mainText = '15';
          break;
      }
    }

    getType();

    return Container(
      decoration: BoxDecoration(
        color: widget.cardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    reportCardIcon,
                    color: Colors.white,
                    size: 36,
                  ),
                  SizedBox(height: 20),
                  Text(
                    titleText,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    mainText,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
