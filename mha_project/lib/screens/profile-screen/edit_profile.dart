import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(
      {super.key,
      required this.hotelPhone,
      required this.hotelEmail,
      required this.hotelName,
      required this.hotelAddress});
  final String hotelName, hotelAddress, hotelPhone, hotelEmail;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _parameter1Controller = TextEditingController();
  final TextEditingController _parameter2Controller = TextEditingController();
  final TextEditingController _parameter4Controller = TextEditingController();
  final TextEditingController _parameter5Controller = TextEditingController();

  void initState() {
    _parameter1Controller.text = widget.hotelPhone;
    _parameter2Controller.text = widget.hotelEmail;
    _parameter4Controller.text = widget.hotelName;
    _parameter5Controller.text = widget.hotelAddress;
    super.initState();
  }

  void EditDialog() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Edit!'),
              content: Text('Are you sure you want to update this object?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      _EditObject();
                    });

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

  void _EditObject() async {
    final enterParameter1 = _parameter1Controller.text;
    final enterParameter2 = _parameter2Controller.text;
    final enterParameter4 = _parameter4Controller.text;
    final enterParameter5 = _parameter5Controller.text;
    Navigator.pop(context, 'Returned');
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'hotel_phone': enterParameter1,
      'hotel_email': enterParameter2,
      'hotel_name': enterParameter4,
      'hotel_address': enterParameter5,
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Edit sucess!'),
      ),
    );
    print('-----------------------------------------');
    // Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  @override
  void dispose() {
    _parameter1Controller.dispose();
    _parameter2Controller.dispose();
    _parameter4Controller.dispose();
    _parameter5Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Hotel\'s profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            letterSpacing: 3.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/hotel_avatar.jpg'),
                  radius: 55.0,
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 27.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              // padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 0.0),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25.0),
                      child: Icon(
                        Icons.phone,
                        color: Colors.grey[400],
                        weight: 400,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: TextField(
                        controller: _parameter1Controller,
                        decoration: InputDecoration(
                          hintText: widget.hotelPhone,
                          // contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 18.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: Icon(
                        Icons.email,
                        color: Colors.grey[400],
                        weight: 400,
                      ),
                    ),
                    SizedBox(width: 25.0),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: TextField(
                          controller: _parameter2Controller,
                          decoration: InputDecoration(
                            hintText: widget.hotelEmail,
                            isDense: true,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 18.0,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
            Divider(
              height: 70.0,
              color: Colors.black,
              indent: 30,
              endIndent: 30,
              thickness: 3,
            ),
            Text(
              'Hotel\'s' ' Information',
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
                child: Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Hotel\'s name      :',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: TextField(
                          controller: _parameter4Controller,
                          decoration: InputDecoration(
                            hintText: widget.hotelName,
                            isDense: true,
                            hintStyle: TextStyle(
                                fontSize: 16.0, color: Colors.grey.shade400),
                          ),
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Hotel\'s address:',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Flexible(
                              child: TextField(
                                controller: _parameter5Controller,
                                decoration: InputDecoration(
                                  hintText: 'Enter your address',
                                  isDense: true,
                                  hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.shade400),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17.0,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Hotel\'s room      :',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        '50+ rooms',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                    ],
                  ),
                ],
              ),
            )),
            SizedBox(
              height: 50.0,
            ),
            Ink(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0)), //<-- SEE HERE
              child: InkWell(
                borderRadius: BorderRadius.circular(100.0),
                onTap: () {
                  setState(() {
                    _EditObject();
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.check,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
