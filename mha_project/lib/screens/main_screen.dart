import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel_tabs_screen.dart';
import 'package:mha_project/screens/profile-screen/profile_screen.dart';
import 'package:mha_project/screens/settings_screen.dart';
import 'package:mha_project/widgets/main_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget chosenScreen;
  String appBarTitle = 'DASHBOARD';

  void _changeTitle(int selectedIndex) {
    setState(() {
      switch (selectedIndex) {
        case 0:
          appBarTitle = 'DASHBOARD';
          break;
        case 1:
          appBarTitle = 'MANAGING';
          break;
        case 2:
          appBarTitle = 'BOOKING';
          break;
        case 3:
          appBarTitle = 'BOOK SERVICE';
          break;
        default:
          break;
      }
    });
  }

  void _setScreen(String identifier) {
    setState(() {
      Navigator.of(context).pop();
      if (identifier == 'hotel') {
        appBarTitle = 'DASHBOARD';
        chosenScreen = TabScreen(changeTitle: _changeTitle);
      }
      if (identifier == 'profile') {
        appBarTitle = 'Profile';
        chosenScreen = ProfileScreen(
          setScreen: _setScreen,
        );
      } else if (identifier == 'settings') {
        appBarTitle = 'Settings';
        chosenScreen = SettingsScreen();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    chosenScreen = TabScreen(
      changeTitle: _changeTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedMainScreen;
    if (appBarTitle == 'Profile') {
      selectedMainScreen = 1;
    } else if (appBarTitle == 'Settings') {
      selectedMainScreen = 2;
    } else {
      selectedMainScreen = 0;
    }
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // add this line to hide bottom contents (nav bar) when showing keyboard

      appBar: appBarTitle == 'Profile'
          ? null
          : AppBar(
              centerTitle: true,
              title: Text(
                appBarTitle,
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 5.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              actions: [
                if (appBarTitle == 'DASHBOARD')
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          _setScreen(identifier);
        },
        selectedMainScreen: selectedMainScreen,
      ),
      body: chosenScreen,
    );
  }
}
