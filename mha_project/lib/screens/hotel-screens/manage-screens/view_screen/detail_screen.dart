import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(
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
  String _setImage() {
    if (categoryName == 'room') {
      return 'assets/images/room.jpg';
    } else if (categoryName == 'service') {
      return 'assets/images/service.jpg';
    } else if (categoryName == 'employee') {
      return 'assets/images/employee.jpg';
    }
    return 'assets/images/customer.jpg';
  }

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
                            child: Image(image: AssetImage(_setImage())),
                          )),
                      Text(
                        '${categoryName[0].toUpperCase()}${categoryName.substring(1).toLowerCase()}\'s information',
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
                                          (categoryName == 'room')
                                              ? 'Room\'s address'
                                              : '${categoryName[0].toUpperCase()}${categoryName.substring(1).toLowerCase()}\'s Id:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text(
                                          (categoryName == 'room')
                                              ? 'Floor:'
                                              : 'Name:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text(
                                          (categoryName == 'room') ||
                                                  (categoryName == 'service')
                                              ? 'Type:'
                                              : 'Email:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text(
                                          (categoryName == 'room')
                                              ? 'Number of bed:'
                                              : 'Number:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      if (categoryName == 'room' ||
                                          categoryName == 'service') ...[
                                        Text('Price:',
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0))
                                      ],
                                      if (categoryName == 'room') ...[
                                        Text('Status:',
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0))
                                      ]
                                    ]),
                                Column(children: [
                                  Text('$parameter1',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Text('$parameter2',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Text('$parameter3',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Text('$parameter4',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  if (categoryName == 'room' ||
                                      categoryName == 'service') ...[
                                    Text('$parameter5\$',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0)),
                                  ],
                                  if (categoryName == 'room') ...[
                                    Text('None',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0))
                                  ]
                                ]),
                              ])),
                          Container(
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
                                  DeleteDialog(context, docId, parameter1);
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
            content: Text('Are you sure you want to delete this object?'),
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
