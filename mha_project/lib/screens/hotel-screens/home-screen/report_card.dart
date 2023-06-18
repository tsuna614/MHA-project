import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firestoreRef = FirebaseFirestore.instance;

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
  double numberOfIncome = 0.0;
  double numberOfRevenue = 0;
  int numberOfOccupancy = 0;
  int numberOfGuests = 0;

  // bool isBookingToday() {}

  DateTime _timestampToDateTime(Timestamp bookingDate) {
    return DateTime.fromMillisecondsSinceEpoch(
        bookingDate.millisecondsSinceEpoch);
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  void getReportData() async {
    final user = FirebaseAuth.instance.currentUser!;

    // GET TODAY'S INCOME
    await firestoreRef
        .collection('booking')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        DateTime bookingDate = _timestampToDateTime(doc['bookingDate']);
        if (_isSameDate(bookingDate, DateTime.now())) {
          setState(() {
            numberOfIncome += doc['price'];
          });
        }
      });
    });

    // GET REVENUE/ROOM
    double totalRevenue = 0;
    double numberOfRooms = 0;
    await firestoreRef
        .collection('room')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        totalRevenue += double.parse(doc['price']);
        numberOfRooms++;
      });
    });
    if (numberOfRooms == 0) numberOfRooms = 1;
    setState(() {
      numberOfRevenue = totalRevenue / numberOfRooms;
    });

    // GET OCCUPANCY RATE + IN-HOUSE GROUPS
    final now = DateTime.now();
    Timestamp arrival, departure;
    await firestoreRef
        .collection('booking')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        arrival = doc['arrival'];
        departure = doc['departure'];
        if (now.compareTo(arrival.toDate()) > 0 &&
            now.compareTo(departure.toDate()) < 0) {
          setState(() {
            numberOfOccupancy++;
            numberOfGuests++;
          });
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReportData();
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
          titleText = 'Revenue/room';
          mainText = numberOfRevenue.toStringAsFixed(1);
          break;
        case 'occupancy':
          reportCardIcon = Icons.bed_outlined;
          titleText = 'Occupancy rate';
          mainText = numberOfOccupancy.toString();
          break;
        case 'guest':
          reportCardIcon = Icons.people;
          titleText = 'In-house groups';
          mainText = numberOfGuests.toString();
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
