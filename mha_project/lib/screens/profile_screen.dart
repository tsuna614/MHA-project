import 'package:flutter/material.dart';
import 'package:mha_project/widgets/my_flutter_app_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Profile',
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
              onPressed: () {},
              icon: Icon(
                MyFlutterApp.edit,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
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
                'Nhat Tan Hotel',
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
                    '(123)-456-7891',
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
                  Text(
                    'nhattan276@gmail.com',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
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
            'Hotel' ' Information',
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
                  children: const [
                    Text(
                      'Hotel name      :',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 50.0),
                        child: Text(
                          'Nhat Tan Hotel',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      'Hotel address:',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    ),
                    Flexible(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20.0, left: 50.0),
                            child: Text(
                              'A street, ward B, Thu Duc district, Ho Chi Minh city',
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
                      'Hotel room      :',
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
