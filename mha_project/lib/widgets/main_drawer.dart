import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;
final firestoreRef = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser!;
late String hotel_name, hotel_email, hotel_image;

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
  void getHotelInformation() async {
    final data = await firestoreRef.collection('users').doc(user.uid);
    await data.get().then((snapshot) {
      setState(() {
        hotel_name = snapshot['hotel_name'];
        hotel_email = snapshot['hotel_email'];
        hotel_image = snapshot['image_url'];
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
                    backgroundImage: NetworkImage(hotel_image),

                    // AssetImage('assets/images/hotel_avatar.jpg'),
                    radius: 50.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    hotel_name + ' Hotel',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(hotel_email),
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
