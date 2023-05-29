import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser!;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      alignment: Alignment.topCenter,
                      height: 125.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: 100, left: 15),
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: const [
                              Text(
                                'Services',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text('50/50'),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                'Room',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text('19/40'),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                'Booking',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text('0'),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                'In-House',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text('73'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.white,
                      width: 400.0,
                      padding:
                          const EdgeInsets.only(top: 223, left: 55, right: 55),
                      child: const TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(fontSize: 18.0),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30.0,
                          ),
                          filled: true,
                        ),
                        //onSubmitted :
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Card(
                    elevation: 6.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.blue,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text('Jaipur')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.blue,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text('Jaipur')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
