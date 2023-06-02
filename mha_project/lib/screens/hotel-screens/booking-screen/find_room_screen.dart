import 'package:flutter/material.dart';

class FindRoomScreen extends StatelessWidget {
  const FindRoomScreen(
      {super.key,
      required this.guestId,
      required this.dateArrival,
      required this.dateDeparture,
      required this.price,
      required this.roomType});

  final String guestId;
  final String dateArrival;
  final String dateDeparture;
  final String price;
  final String roomType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(guestId),
            Text(dateArrival),
            Text(dateDeparture),
            Text(price),
            Text(roomType),
          ],
        ),
      ),
    );
  }
}
