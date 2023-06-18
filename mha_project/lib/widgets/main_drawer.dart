import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;
final firestoreRef = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser!;

class MainDrawer extends StatefulWidget {
  const MainDrawer(
      {super.key,
      required this.onSelectScreen,
      required this.selectedMainScreen});

  final void Function(String identifier) onSelectScreen;

  final int selectedMainScreen;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String hotelName = '';
  String hotelEmail = '';
  String hotelImage = '';

  void getHotelInformation() async {
    final data = firestoreRef.collection('users').doc(user.uid);
    await data.get().then((snapshot) {
      setState(() {
        hotelName = snapshot['hotel_name'];
        hotelEmail = snapshot['hotel_email'];
        hotelImage = snapshot['image_url'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getHotelInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 260,
            child: DrawerHeader(
              padding: const EdgeInsets.all(20),
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(colors: [
              //   Theme.of(context).colorScheme.primaryContainer,
              //   Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5)
              // ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              // decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.primaryContainer),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(hotelImage),

                    // AssetImage('assets/images/hotel_avatar.jpg'),
                    radius: 50.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$hotelName Hotel',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(hotelEmail),
                ],
              ),
            ),
          ),
          Container(
            color: widget.selectedMainScreen == 0
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : null,
            child: ListTile(
              leading: Icon(
                Icons.hotel,
                size: 26,
                color: Colors.black,
              ),
              title: Text(
                'Hotel',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                widget.onSelectScreen('hotel');
              },
            ),
          ),
          Container(
            color: widget.selectedMainScreen == 1
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : null,
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 26,
                color: Colors.black,
              ),
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                widget.onSelectScreen('profile');
              },
            ),
          ),
          Container(
            color: widget.selectedMainScreen == 2
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : null,
            child: ListTile(
              leading: Icon(
                Icons.settings,
                size: 26,
                color: Colors.black,
              ),
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                widget.onSelectScreen('settings');
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Colors.red.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  _firebase.signOut();
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16),
                )),
          ),
        ],
      ),
    );
  }
}
