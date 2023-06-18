import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mha_project/screens/hotel-screens/home-screen/chart/bar_graph.dart';
import 'package:intl/intl.dart';

final firestoreRef = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser!;

class MyBarChart extends StatefulWidget {
  MyBarChart({super.key});

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  double day1Value = 0;
  double day2Value = 0;
  double day3Value = 0;
  double day4Value = 0;
  double day5Value = 0;
  double day6Value = 0;
  double day7Value = 0;

  double highestValue = 0;

  late DateTime lastMondayDate;

  DateTime timestampToDateTime(Timestamp bookingDate) {
    return DateTime.fromMillisecondsSinceEpoch(
        bookingDate.millisecondsSinceEpoch);
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  double findHighestValue(double day1, double day2, double day3, double day4,
      double day5, double day6, double day7) {
    double temp = day1;
    if (temp < day2) {
      temp = day2;
    }
    if (temp < day3) {
      temp = day3;
    }
    if (temp < day4) {
      temp = day4;
    }
    if (temp < day5) {
      temp = day5;
    }
    if (temp < day6) {
      temp = day6;
    }
    if (temp < day7) {
      temp = day7;
    }
    return temp;
  }

  void getLastWeekRevenue() async {
    DateTime now = DateTime.now();
    String currentDayOfWeek = DateFormat('EEEE').format(now);
    switch (currentDayOfWeek) {
      case 'Monday':
        lastMondayDate = now.subtract(const Duration(days: 7));
        break;
      case 'Tuesday':
        lastMondayDate = now.subtract(const Duration(days: 8));
        break;
      case 'Wednesday':
        lastMondayDate = now.subtract(const Duration(days: 9));
        break;
      case 'Thursday':
        lastMondayDate = now.subtract(const Duration(days: 10));
        break;
      case 'Friday':
        lastMondayDate = now.subtract(const Duration(days: 11));
        break;
      case 'Saturday':
        lastMondayDate = now.subtract(const Duration(days: 12));
        break;
      case 'Sunday':
        lastMondayDate = now.subtract(const Duration(days: 13));
        break;
      default:
        lastMondayDate = now;
        break;
    }

    // GET TODAY'S INCOME
    await firestoreRef
        .collection('booking')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        DateTime bookingDate = timestampToDateTime(doc['bookingDate']);
        // if (isSameDate(bookingDate, DateTime.now())) {
        //   setState(() {
        //     numberOfIncome += doc['price'];
        //   });
        // }
        setState(() {
          if (isSameDate(bookingDate, lastMondayDate)) {
            day1Value += doc['price'];
          } else if (isSameDate(
              bookingDate, lastMondayDate.add(const Duration(days: 1)))) {
            day2Value += doc['price'];
          } else if (isSameDate(
              bookingDate, lastMondayDate.add(const Duration(days: 2)))) {
            day3Value += doc['price'];
          } else if (isSameDate(
              bookingDate, lastMondayDate.add(const Duration(days: 3)))) {
            day4Value += doc['price'];
          } else if (isSameDate(
              bookingDate, lastMondayDate.add(const Duration(days: 4)))) {
            day5Value += doc['price'];
          } else if (isSameDate(
              bookingDate, lastMondayDate.add(const Duration(days: 5)))) {
            day6Value += doc['price'];
          } else if (isSameDate(
              bookingDate, lastMondayDate.add(const Duration(days: 6)))) {
            day7Value += doc['price'];
          }
        });
      });
    });

    highestValue = findHighestValue(day1Value, day2Value, day3Value, day4Value,
        day5Value, day6Value, day7Value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLastWeekRevenue();
  }

  // getLastWeekRevenue();

  @override
  Widget build(BuildContext context) {
    List<double> weeklyRevenue = [
      day1Value,
      day2Value,
      day3Value,
      day4Value,
      day5Value,
      day6Value,
      day7Value,
    ];

    return MyBarGraph(
      weeklyRevenue: weeklyRevenue,
      highestValue: highestValue,
    );
  }
}
