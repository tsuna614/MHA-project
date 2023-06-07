import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/view_screen/edit_screen.dart';

final firestoreRef = FirebaseFirestore.instance;

class DetailScreen extends StatefulWidget {
  DetailScreen(
      {super.key,
      required this.categoryName,
      required this.parameter1,
      required this.parameter2,
      required this.parameter3,
      required this.parameter4,
      required this.parameter5,
      required this.showBottomSheetHeight,
      required this.docId});
  final String parameter1,
      parameter2,
      parameter3,
      parameter4,
      parameter5,
      docId,
      categoryName;
  final double showBottomSheetHeight;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isAvailable = true;

  String _setImage() {
    if (widget.categoryName == 'room') {
      return 'assets/images/room.jpg';
    } else if (widget.categoryName == 'service') {
      return 'assets/images/service.jpg';
    } else if (widget.categoryName == 'employee') {
      return 'assets/images/employee.jpg';
    }
    return 'assets/images/customer.jpg';
  }

  Future<DateTime> getDateArrival(roomId) async {
    Timestamp arrival, departure;
    late DateTime dateOfArrival;
    // , dateOfDeparture;
    final data = await firestoreRef
        .collection('booking')
        .where('roomId', isEqualTo: roomId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        arrival = doc['arrival'];
        dateOfArrival = arrival.toDate();
        // departure = doc['departure'];
        // dateOfDeparture = departure.toDate();
      });
    });
    return dateOfArrival;
  }

  Future<DateTime> getDateDeparture(String roomId) async {
    Timestamp arrival, departure;
    late DateTime dateOfDeparture;
    // , dateOfDeparture;
    final data = await firestoreRef
        .collection('booking')
        .where('roomId', isEqualTo: roomId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        // arrival = doc['arrival'];
        // dateOfArrival = arrival.toDate();
        departure = doc['departure'];
        dateOfDeparture = departure.toDate();
      });
    });
    return dateOfDeparture;
  }

  void checkStatus(String roomId) async {
    final now = DateTime.now();
    DateTime dateOfArrival = await getDateArrival(roomId);
    DateTime dateOfDeparture = await getDateDeparture(roomId);
    print(dateOfArrival);
    print(dateOfDeparture);
    if (now.compareTo(dateOfArrival) > 0 &&
        now.compareTo(dateOfDeparture) < 0) {
      print('Not available');
      setState(() {
        isAvailable = false;
      });
    } else {
      print('Available');
      setState(() {
        isAvailable = true;
      });
    }
  }

  @override
  initState() {
    super.initState();
    checkStatus(widget.docId);
  }

  // void checkStatus() {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          // if (categoryName == "room") {
          //   checkStatus();
          // }
          showModalBottomSheet(
              context: context,
              isScrollControlled:
                  true, // this line will make the bottom sheet go all the way up (show full of its height)
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
              ), // this line will round the top left and right corners of bottom sheet
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    height: widget.showBottomSheetHeight,
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.all(20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(image: AssetImage(_setImage())),
                          )),
                      Text(
                        '${widget.categoryName[0].toUpperCase()}${widget.categoryName.substring(1).toLowerCase()}\'s information',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          (widget.categoryName == 'room')
                                              ? 'Room\'s address'
                                              : '${widget.categoryName[0].toUpperCase()}${widget.categoryName.substring(1).toLowerCase()}\'s Id:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text(
                                          (widget.categoryName == 'room')
                                              ? 'Floor:'
                                              : 'Name:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('Type:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text(
                                          (widget.categoryName == 'room')
                                              ? 'Number of bed:'
                                              : 'Number:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      if (widget.categoryName == 'room' ||
                                          widget.categoryName == 'service') ...[
                                        Text('Price:',
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0))
                                      ] else if (widget.categoryName ==
                                              'employee' ||
                                          widget.categoryName ==
                                              'customer') ...[
                                        Text('Email:',
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0))
                                      ],
                                      if (widget.categoryName == 'room') ...[
                                        Text('Status:',
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0))
                                      ]
                                    ]),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${widget.parameter1}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('${widget.parameter2}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('${widget.parameter3}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('${widget.parameter4}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text(
                                          (widget.categoryName == 'room' ||
                                                  widget.categoryName ==
                                                      'service')
                                              ? '${widget.parameter5}\$'
                                              : '${widget.parameter5}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      if (widget.categoryName == 'room') ...[
                                        // Text('None',
                                        //     style: TextStyle(
                                        //         color: Colors.black,
                                        //         fontWeight: FontWeight.bold,
                                        //         fontSize: 18.0))
                                        // StayedDate(roomId: docId)

                                        Text(
                                            // ignore: unrelated_type_equality_checks
                                            (isAvailable == false)
                                                ? 'Not Available'
                                                : 'Available',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            )),
                                      ]
                                    ]),
                              ])),
                          SizedBox(height: 40),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => EditScreen(
                                                  categoryName:
                                                      widget.categoryName,
                                                  parameter1: widget.parameter1,
                                                  parameter2: widget.parameter2,
                                                  parameter3: widget.parameter3,
                                                  parameter4: widget.parameter4,
                                                  parameter5: widget.parameter5,
                                                  showBottomSheetHeight: widget
                                                      .showBottomSheetHeight,
                                                  docId: widget.docId)));
                                    },
                                    child: Text('Edit'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 138, 163, 255)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      DeleteDialog(context, widget.docId,
                                          widget.categoryName);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: Text('Delete'),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ]),
                      ),
                    ]),
                  ),
                );
              });
        },
        icon: Icon(Icons.info),
        label: Text('Show Detail'));
  }
}

void DeleteDialog(context, id, categoryName) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text('Delete!'),
            content: Text('Are you sure you want to delete this object?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black.withOpacity(0.8)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  _deleteObject(context, id, categoryName);
                  // Navigator.of(context).pop(context);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ));
}

void _deleteObject(context, id, categoryName) async {
  await FirebaseFirestore.instance.collection(categoryName).doc(id).delete();

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Delete sucess!'),
    ),
  );

  // pop 2 screens
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= 2);

  // SnackBar(content: const Text('Delete sucess!'));
}
