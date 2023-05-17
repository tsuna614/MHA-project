import 'package:flutter/material.dart';
//Room
import 'package:mha_project/screens/Rooms/Create_Room_Screen.dart';
import 'package:mha_project/screens/Rooms/View_Room_Scree.dart';
import 'package:mha_project/screens/Rooms/Delele_Room_Screen.dart';
//Services
import 'package:mha_project/screens/Services/Create_Services.dart';
import 'package:mha_project/screens/Services/View_Services.dart';
import 'package:mha_project/screens/Services/Delete_Services.dart';
//Employee
import 'package:mha_project/screens/Employee/Create_Employee_Screen.dart';
import 'package:mha_project/screens/Employee/Delete_Employee_Screen.dart';
import 'package:mha_project/screens/Employee/View_Employee_Screen.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MANAGING',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            letterSpacing: 5.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
//Rooms
                Container(
                    height: 200,
                    width: 700,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Rooms',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 3.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     // CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Create_Room_Screen()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(35.0, 30.0)),
                                            child: Text(
                                              'Create Room',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          View_Room_Screen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(35.0, 30.0)),
                                            child: Text(
                                              'View Room',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Delete_Room_Screen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(25.0, 30.0)),
                                            child: Text(
                                              'Delete Room',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  height: 130,
                                  width: 150,
                                  child: Image.asset('assets/Room.jpg',
                                      fit: BoxFit.cover),
                                ))
                          ],
                        ))),
//Services
                SizedBox(
                  height: 15.0,
                ),
                Container(
                    height: 200,
                    width: 700,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  // mainAxisAlignment:
                                  // MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Services',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 3.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     // CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Create_Services_Screen()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(35.0, 30.0)),
                                            child: Text(
                                              'Create Services',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          View_Services_Screen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(35.0, 30.0)),
                                            child: Text(
                                              'View Services',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Delete_Services_Screen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(25.0, 30.0)),
                                            child: Text(
                                              'Delete Services',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  height: 130,
                                  width: 150,
                                  child: Image.asset('assets/service.jpg',
                                      fit: BoxFit.cover),
                                ))
                          ],
                        ))),
//Employee
                SizedBox(
                  height: 15.0,
                ),
                Container(
                    height: 200,
                    width: 700,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  // mainAxisAlignment:
                                  // MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Employee',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 3.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     // CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Create_Employee_Screen()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(35.0, 30.0)),
                                            child: Text(
                                              'Create Employee',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          View_Employee_Screen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(35.0, 30.0)),
                                            child: Text(
                                              'View Employee',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Delete_Employee_Screen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 137, 207, 240),
                                                minimumSize:
                                                    const Size(25.0, 30.0)),
                                            child: Text(
                                              'Delete Employee',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  height: 130,
                                  width: 150,
                                  child: Image.asset('assets/employee.jpg',
                                      fit: BoxFit.cover),
                                ))
                          ],
                        )))
              ]),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 223, 221, 221),
    );
  }
}
