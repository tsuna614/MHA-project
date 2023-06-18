import 'package:flutter/material.dart';

import 'package:mha_project/screens/hotel-screens/booking-screen/booking_screen.dart';
import 'package:mha_project/screens/hotel-screens/home-screen/home_screen.dart';
import 'package:mha_project/screens/hotel-screens/service-booking-screen/service_booking_screen.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/manage_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key, required this.changeTitle});

  // call a function in main_screen.dart and passes an index to it to switch appBar's title
  final void Function(int selectedIndex) changeTitle;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;

  // void _onItemTapped(itemIndex) {
  //   setState(() {
  //     _selectedIndex = itemIndex;
  //     switch (itemIndex) {
  //       case 0:
  //         chosenScreen = const HomeScreen();
  //         widget.changeTitle(0);
  //         break;
  //       case 1:
  //         chosenScreen = const ManageScreen();
  //         widget.changeTitle(1);
  //         break;
  //       case 2:
  //         chosenScreen = const BookingScreen();
  //         widget.changeTitle(2);
  //         break;
  //       case 3:
  //         chosenScreen = const NotificationsScreen();
  //         widget.changeTitle(3);
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  // }

  final _pages = [
    HomeScreen(),
    ManageScreen(),
    BookingScreen(),
    AddServiceScreen(),
  ];
  final _pageController = PageController();

  Widget chosenScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
          widget.changeTitle(index);
        },
        controller: _pageController,
        children: _pages,
      ),
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
                icon: Icon(Icons.dining_rounded),
                label: 'Service',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(_selectedIndex,
                    duration: Duration(milliseconds: 1), curve: Curves.linear);
                widget.changeTitle(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
