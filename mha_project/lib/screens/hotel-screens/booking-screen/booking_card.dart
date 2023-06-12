import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/booking-screen/booking_detail.dart';

class BookingCard extends StatefulWidget {
  const BookingCard(
      {super.key,
      required this.guestId,
      required this.dateArrival,
      required this.dateDeparture,
      required this.roomPrice,
      required this.roomType,
      required this.roomAddress,
      required this.userId,
      required this.docId});
  final String guestId, //parameter3: type (for all object)
      roomType, //parameter4: beds(room)/number (sesrvice&customer&employee)
      roomAddress, //parameter5: price (room&service) / email(employee&customer)
      userId,
      docId;
  final Timestamp dateArrival, dateDeparture;
  final int roomPrice;

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // this line will make the bottom sheet go all the way up (show full of its height)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ), // this line will round the top left and right corners of bottom sheet
            builder: (BuildContext context) {
              return BookingDetail(
                  guestId: widget.guestId,
                  dateArrival: widget.dateArrival,
                  dateDeparture: widget.dateDeparture,
                  roomPrice: widget.roomPrice,
                  roomType: widget.roomType,
                  roomAddress: widget.roomAddress,
                  docId: widget.docId);
            });
      },
      child: Container(
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
                  'Room ${widget.roomAddress}',
                  // ${categoryName[0].toUpperCase()}${categoryName.substring(1).toLowerCase()}
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Type: ${widget.roomType} \nPrice: ${widget.roomPrice}',
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
          )),
    );
  }
}
