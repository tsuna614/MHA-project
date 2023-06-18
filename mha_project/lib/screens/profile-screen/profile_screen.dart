import 'package:flutter/material.dart';
import 'package:mha_project/widgets/main_drawer.dart';
import 'package:mha_project/widgets/my_flutter_app_icons.dart';
import 'package:mha_project/screens/profile-screen/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

late String realHotelName, realHotelAddress, realHotelEmail, realHotelPhone;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.setScreen});

  final void Function(String identifier) setScreen;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firestoreRef = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  void getHotelName() async {
    DocumentReference documentReference =
        await firestoreRef.collection('users').doc(user.uid);
    await documentReference.get().then((snapshot) {
      setState(() {
        realHotelName = snapshot['hotel_name'];
        realHotelPhone = snapshot['hotel_phone'];
        realHotelAddress = snapshot['hotel_address'];
        realHotelEmail = snapshot['hotel_email'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getHotelName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          IconButton(
              onPressed: () {
                editScreen(context);
              },
              icon: Icon(
                MyFlutterApp.edit,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          widget.setScreen(identifier);
        },
        selectedMainScreen: 1,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/hotel_avatar.jpg'),
                radius: 55.0,
              ),
              Text(
                '$realHotelName +  Hotel',
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
            padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 0.0),
            child: Column(children: [
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.grey[400],
                    weight: 400,
                  ),
                  SizedBox(
                    width: 18.0,
                  ),
                  Text(
                    realHotelPhone,
                    // = '(123)-456-7891',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.grey[400],
                    weight: 400,
                  ),
                  SizedBox(
                    width: 18.0,
                  ),
                  Flexible(
                      child: Text(
                    realHotelEmail,
                    // = 'nhattan276@gmail.com',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
            ]),
          ),
          Divider(
            height: 90.0,
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
                    Text(
                      'Hotel\'s name      :',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 50.0),
                        child: Text(
                          realHotelName + ' Hotel',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Hotel\'s address:',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    ),
                    Flexible(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20.0, left: 50.0),
                            child: Text(
                              realHotelAddress,
                              // =
                              //     'A street, ward B, Thu Duc district, Ho Chi Minh city',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )))
                  ],
                ),
                SizedBox(
                  height: 17.0,
                ),
                Row(
                  children: const [
                    Text(
                      'Hotel\'s room      :',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 50.0),
                        child: Text(
                          '50+ rooms',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))
                  ],
                ),
              ],
            ),
          ))
        ]),
      ),
      backgroundColor: Colors.white,
    );
  }
}

void editScreen(context) async {
  await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditProfileScreen(
          hotelPhone: realHotelPhone,
          hotelAddress: realHotelAddress,
          hotelEmail: realHotelEmail,
          hotelName: realHotelName)));
}
