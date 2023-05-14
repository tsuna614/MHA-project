import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.topCenter,
                height: 250.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(30, 8),
                    bottomRight: Radius.elliptical(30, 8),
                  ),
                  color: Colors.blueAccent,
                ),
                //child: Image.asset("assets/bgImage.jpg"),
              ),
              Container(
                //color: Colors.white,
                width: 400.0,
                padding: const EdgeInsets.only(top: 223, left: 55, right: 55),
                child: const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
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
    );
  }
}
