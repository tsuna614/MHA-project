import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel_screens/manage_screens/manage_card.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MANAGING',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            letterSpacing: 5.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ManageCard(
                categoryName: 'ROOM',
                categoryImage: Image.asset('assets/images/room.jpg'),
              ),
              SizedBox(height: 20.0),
              ManageCard(
                categoryName: 'SERVICES',
                categoryImage: Image.asset('assets/images/service.jpg'),
              ),
              SizedBox(height: 20.0),
              ManageCard(
                categoryName: 'EMPLOYEE',
                categoryImage: Image.asset('assets/images/employee.jpg'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
