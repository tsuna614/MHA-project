import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mha_project/screens/hotel-screens/booking_screen.dart';
import 'package:mha_project/screens/hotel-screens/home_screen.dart';
import 'package:mha_project/screens/hotel-screens/notifications_screen.dart';
import 'package:mha_project/screens/profile_screen.dart';
import 'package:mha_project/screens/settings_screen.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/manage_screen.dart';
import 'package:mha_project/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key, required this.changeTitle});

  final void Function(int selectedIndex) changeTitle;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  var _selectedScreenTitle = 'DASHBOARD';

  void _onItemTapped(itemIndex) {
    setState(() {
      _selectedIndex = itemIndex;
      switch (itemIndex) {
        case 0:
          chosenScreen = const HomeScreen();
          widget.changeTitle(0);
          _selectedScreenTitle = 'DASHBOARD';
          break;
        case 1:
          chosenScreen = const ManageScreen();
          widget.changeTitle(1);
          _selectedScreenTitle = 'MANAGING';
          break;
        case 2:
          chosenScreen = const BookingScreen();
          widget.changeTitle(2);
          _selectedScreenTitle = 'BOOKING';
          break;
        case 3:
          chosenScreen = const NotificationsScreen();
          widget.changeTitle(3);
          _selectedScreenTitle = 'NOTIFICATION';
          break;
        default:
          break;
      }
    });
  }

  Widget chosenScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chosenScreen,
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Theme.of(context).primaryColor),
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
                icon: Icon(Icons.add_business),
                label: 'Booking',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notification',
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
