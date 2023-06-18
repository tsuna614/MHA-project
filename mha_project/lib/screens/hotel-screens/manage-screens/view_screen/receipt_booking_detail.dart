import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class receiptBookingDetail extends StatefulWidget {
  receiptBookingDetail(
      {super.key,
      required this.customerName,
      required this.guestId,
      required this.customerType,
      required this.dateArrival,
      required this.dateDeparture,
      required this.roomPrice,
      required this.roomType,
      required this.docId});

  final String guestId, roomType, docId, customerType, customerName;
  final int roomPrice;
  Timestamp dateArrival, dateDeparture;

  @override
  State<receiptBookingDetail> createState() => _receiptBookingDetailState();
}

class _receiptBookingDetailState extends State<receiptBookingDetail> {
  final user = FirebaseAuth.instance.currentUser!;
  String converTimeStampToString(date) {
    Timestamp originTime;
    late DateTime dateConvert;
    originTime = date;
    dateConvert = originTime.toDate();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateConvert);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 700,
        child: Column(children: [
          Container(
              margin: EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(image: AssetImage('assets/images/room.jpg')),
              )),
          Text(
            'Booking\'s information',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            // height: ,
            endIndent: 150,
            indent: 150,
            thickness: 2,
            color: Colors.black,
          ),
          SizedBox(height: 20.0),
          Container(
            child: Column(children: [
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Guest\'s Id:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('Guest\'s Name:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('Guest\'s Type:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('arrival:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('departure:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('Room Price:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('Room type:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.guestId}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('${widget.customerName}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('${widget.customerType}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text(converTimeStampToString(widget.dateArrival),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text(converTimeStampToString(widget.dateDeparture),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('\$ ${widget.roomPrice}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text('${widget.roomType}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                        ]),
                  ])),
            ]),
          ),
        ]),
      ),
    );
  }
}
