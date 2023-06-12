import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(
      {super.key,
      required this.parameter1,
      required this.parameter2,
      required this.parameter3,
      required this.parameter4,
      required this.parameter5,
      required this.userId,
      required this.docId});
  final String
      parameter1, //parameter1: address(room)/id (service&customer&employee)
      parameter2, //parameter2: floor(room)/name (service&customer&employee)
      parameter3, //parameter3: type (for all object)
      parameter4, //parameter4: beds(room)/number (sesrvice&customer&employee)
      parameter5, //parameter5: price (room&service) / email(employee&customer)
      userId,
      docId;

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
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Room $parameter1',
                // ${categoryName[0].toUpperCase()}${categoryName.substring(1).toLowerCase()}
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Type: $parameter3 \nBed number: $parameter4',
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
            ),
            // DetailScreen(
            //     categoryName: categoryName,
            //     parameter1: parameter1,
            //     parameter2: parameter2,
            //     parameter3: parameter3,
            //     parameter4: parameter4,
            //     parameter5: parameter5,
            //     showBottomSheetHeight: showBottomSheetHeight,
            //     docId: docId)
          ],
        ));
  }
}
