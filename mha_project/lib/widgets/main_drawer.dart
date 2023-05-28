import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class MainDrawer extends StatelessWidget {
  const MainDrawer(
      {super.key,
      required this.onSelectScreen,
      required this.selectedMainScreen});

  final void Function(String identifier) onSelectScreen;

  final int selectedMainScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(colors: [
            //   Theme.of(context).colorScheme.primaryContainer,
            //   Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5)
            // ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            // decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.primaryContainer),
            child: Column(
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/hotel_avatar.jpg'),
                  radius: 55.0,
                ),
              ],
            ),
          ),
          Container(
            color: selectedMainScreen == 0
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
                onSelectScreen('hotel');
              },
            ),
          ),
          Container(
            color: selectedMainScreen == 1
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
                onSelectScreen('profile');
              },
            ),
          ),
          Container(
            color: selectedMainScreen == 2
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
                onSelectScreen('settings');
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
