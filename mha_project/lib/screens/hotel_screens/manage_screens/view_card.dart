import 'package:flutter/material.dart';

class ViewCard extends StatelessWidget {
  const ViewCard(
      {super.key,
      required this.address,
      required this.beds,
      required this.floor,
      required this.price,
      required this.type});
  final String address;
  final String beds;
  final String floor;
  final String price;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(128, 196, 194, 194),
                blurRadius: 4,
                offset: Offset(4, 8))
          ],
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Room $address',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            'Type: $type \nBed number: $beds',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.grey[400],
            ),
          ),
          isThreeLine: true,
          trailing: CircleAvatar(
            backgroundImage: AssetImage('assets/images/room.jpg'),
            radius: 30.0,
          ),
        ));
  }
}
