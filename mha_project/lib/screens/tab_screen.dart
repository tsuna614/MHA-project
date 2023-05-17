import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mha_project/screens/booking_screen.dart';
import 'package:mha_project/screens/home_screen.dart';
import 'package:mha_project/screens/notifications_screen.dart';
import 'package:mha_project/screens/profile_screen.dart';
import 'package:mha_project/screens/settings_screen.dart';
import 'package:mha_project/screens/manage_screen.dart';
import 'package:mha_project/widgets/main_drawer.dart';

final _firebase = FirebaseAuth.instance;

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(itemIndex) {
    setState(() {
      _selectedIndex = itemIndex;
      switch (itemIndex) {
        case 0:
          chosenScreen = const HomeScreen();
          break;
        case 1:
          chosenScreen = const ManageScreen();
          break;
        case 2:
          chosenScreen = const NotificationsScreen();
          break;
        case 3:
          chosenScreen = const SettingsScreen();
          break;
        default:
          break;
      }
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'profile') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    }
    if (identifier == 'settings') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ),
      );
    }
  }

  Widget chosenScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              centerTitle: false,
              title: const Text(
                'DASHBOARD',
                style: TextStyle(fontSize: 30),
              ),
              elevation: _selectedIndex == 0 ? 0 : 3,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            )
          : null,
      drawer: MainDrawer(onSelectScreen: (identifier) {
        _setScreen(identifier);
      }),
      body: chosenScreen,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Theme.of(context).colorScheme.primary),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Manage',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
