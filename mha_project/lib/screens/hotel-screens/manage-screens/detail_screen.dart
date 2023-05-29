import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(
      {super.key,
      required this.address,
      required this.beds,
      required this.floor,
      required this.price,
      required this.type,
      required this.showBottomSheetHeight,
      required this.docId});
  final String address, beds, floor, price, type, docId;
  final double showBottomSheetHeight;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    height: showBottomSheetHeight,
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.all(20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset('assets/images/room.jpg'),
                          )),
                      Text(
                        'Room\'s information',
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
                                    children: const [
                                      Text('Room\'s address:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('Floor:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('Type:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('Number of bed:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('Price:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('Status:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                    ]),
                                Column(children: [
                                  Text('$address',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Text('$floor',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Text('$type',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Text('$beds',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Text('$price',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Text('None',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0))
                                ]),
                              ])),
                          Container(
                              // margin: EdgeInsets.only(top: 50.0, bottom: 30.0),
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Edit'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 138, 163, 255)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  DeleteDialog(context, docId, address);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: Text('Delete'),
                              ),
                            ],
                          ))
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

void DeleteDialog(context, id, name) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text('Delete'),
            content: Text('Are you sure you want to delete this object'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _deleteObject(context, id, name);
                  // Navigator.of(context).pop(context);
                },
                child: Text('Sure'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('Cancel'),
              ),
            ],
          ));
}

void _deleteObject(context, id, name) async {
  await FirebaseFirestore.instance.collection('room').doc(id).delete();

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
