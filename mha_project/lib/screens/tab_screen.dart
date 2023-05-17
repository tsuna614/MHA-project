import 'package:flutter/material.dart';
import 'package:mha_project/screens/manage_screen.dart';
import 'package:mha_project/screens/home_screen.dart';
import 'package:mha_project/screens/notifications_screen.dart';
import 'package:mha_project/screens/settings_screen.dart';

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

  Widget chosenScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Hotel Management Application'),
      // ),
      body: Center(
        child: chosenScreen,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Theme.of(context).colorScheme.primary),
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
    );
  }
}
