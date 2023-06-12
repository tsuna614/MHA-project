import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BookingDetail extends StatefulWidget {
  BookingDetail(
      {super.key,
      required this.guestId,
      required this.dateArrival,
      required this.dateDeparture,
      required this.roomPrice,
      required this.roomType,
      required this.roomAddress,
      required this.docId});

  final String guestId, roomAddress, roomType, docId;
  final int roomPrice;
  Timestamp dateArrival, dateDeparture;

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  String converTimeStampToString(date) {
    Timestamp originTime;
    late DateTime dateConvert;
    originTime = date;
    dateConvert = originTime.toDate();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateConvert);
    return formatted;
  }

  void _submitCreateRoom(
      price, id, dayArrival, dayDeparture, idOfCustomer, typeOfRoom) {
    final Timestamp now = _dateTimeToTimestamp(DateTime.now());
    // print(enteredTextField1);
    // print(enteredTextField2);
    // print(enteredTextField3);
    // print(enteredTextField4);
    // print(selectedType);
    try {
      CollectionReference roomRef =
          FirebaseFirestore.instance.collection('booking');
      DocumentReference newRoomRef = roomRef.doc();
      newRoomRef.set(
        {
          'arrival': dayArrival,
          'customerId': idOfCustomer,
          'departure': dayDeparture,
          'price': price,
          'roomId': id,
          'type': typeOfRoom,
          'bookingDate': now,
        },
      );
      FocusScope.of(context).unfocus();
    } on FirebaseAuthException catch (error) {
      print(error);
    }
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => FindRoomScreen(
    //             guestId: enteredTextField1,
    //             dateArrival: enteredTextField2,
    //             dateDeparture: enteredTextField3,
    //             price: enteredTextField4,
    //             roomType: selectedType)));
  }

  Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
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
                          Text('Guest\'s Id',
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
                          Text('Room address:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.guestId}',
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
                          Text('${widget.roomAddress}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                        ]),
                  ])),
              SizedBox(height: 40),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    _submitCreateRoom(
                        widget.roomPrice,
                        widget.docId,
                        widget.dateArrival,
                        widget.dateDeparture,
                        widget.guestId,
                        widget.guestId);
                  },
                  child: Text('CONFIRM'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 138, 163, 255)),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
