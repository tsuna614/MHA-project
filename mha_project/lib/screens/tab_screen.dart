import 'package:flutter/material.dart';
import 'package:mha_project/screens/booking_screen.dart';
import 'package:mha_project/screens/home_screen.dart';
import 'package:mha_project/screens/notifications_screen.dart';
import 'package:mha_project/screens/settings_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key, required this.activateToken});

  final void Function() activateToken;

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
          chosenScreen = const BookingScreen();
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
                IconButton(
                    onPressed: widget.activateToken,
                    icon: const Icon(Icons.logout))
              ],
            )
          : null,
      body: chosenScreen,
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