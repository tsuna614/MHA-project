import 'dart:ffi';

import 'package:flutter/material.dart';

class ViewCard extends StatelessWidget {
  const ViewCard(
      {super.key,
      required this.address,
      required this.beds,
      required this.floor,
      required this.price,
      required this.type,
      required this.showBottomSheetHeight});
  final String address, beds, floor, price, type;
  final double showBottomSheetHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(128, 196, 194, 194),
                blurRadius: 4,
                offset: Offset(4, 8))
          ],
        ),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Room $address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Type: $type \nBed number: $beds',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.grey[400],
                ),
              ),
              isThreeLine: true,
              trailing: CircleAvatar(
                backgroundImage: AssetImage('assets/images/room.jpg'),
                radius: 30.0,
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          height: showBottomSheetHeight,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child:
                                        Image.asset('assets/images/room.jpg'),
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
                                endIndent: 175,
                                indent: 175,
                                thickness: 2,
                                color: Colors.black,
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                margin: EdgeInsets.only(left: 50.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Room\'s address:',
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0)),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 100.0),
                                            child: Text('$address',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0)))
                                      ],
                                    ),
                                    Row(children: [
                                      Text('Floor:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Padding(
                                          padding: EdgeInsets.only(left: 181.0),
                                          child: Text('$floor',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0)))
                                    ]),
                                    Row(children: [
                                      Text('Type:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      SizedBox(width: 160),
                                      Text('$type',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                    ]),
                                    Row(children: [
                                      Text('Number of bed:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      SizedBox(width: 105.0),
                                      Text('$beds',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0))
                                    ]),
                                    Row(children: [
                                      Text('Price:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('$price',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0))
                                    ]),
                                    Row(children: const [
                                      Text('Status:',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                      Text('None',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0))
                                    ]),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Edit'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 138, 163, 255)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: Text('Delete'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(Icons.info),
                label: Text('Show Detail'))
          ],
        ));
  }
}
