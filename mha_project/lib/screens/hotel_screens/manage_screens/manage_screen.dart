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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ManageCard(
              categoryName: 'ROOM',
              categoryImage: Image.asset('assets/images/room.jpg'),
            ),
            SizedBox(height: 40.0),
            ManageCard(
              categoryName: 'SERVICE',
              categoryImage: Image.asset('assets/images/service.jpg'),
            ),
            SizedBox(height: 40.0),
            ManageCard(
              categoryName: 'EMPLOYEE',
              categoryImage: Image.asset('assets/images/employee.jpg'),
            ),
            SizedBox(height: 40.0),
            ManageCard(
              categoryName: 'CUSTOMER',
              categoryImage: Image.asset('assets/images/customer.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
