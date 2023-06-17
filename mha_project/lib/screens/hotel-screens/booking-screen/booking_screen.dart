import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mha_project/screens/hotel-screens/booking-screen/find_room_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/view_screen/detail_screen.dart';

final List<String> roomType = [
  "SINGLE",
  "DOUBLE",
  "QUAD",
  "TWIN",
  "STANDARD",
  "SUPERIOR",
  "DELUXE",
  "EXECUTIVE",
];

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final _textField1Controller = TextEditingController();
  TextEditingController dateinputArrival = TextEditingController();
  TextEditingController dateinputDeparture = TextEditingController();
  final _textField4Controller = TextEditingController();
  var _selectedRoomType = roomType[0];

  bool isTextFieldNumberValid(String text) {
    if (double.tryParse(text) == null) {
      return false;
    }
    if (double.tryParse(text)! < 0) {
      return false;
    }
    return true;
  }

  void findBooking() async {
    List<String> roomsId = [];
    List<String> availabeRooms = [];
    List<String> notAvailableRooms = [];
    final String guestId = _textField1Controller.text;
    int bookingPrice = int.parse(_textField4Controller.text);
    final enteredTextField1 = _textField1Controller.text;
    final enteredTextField2 = dateinputArrival.text;
    final enteredTextField3 = dateinputDeparture.text;
    var errorMessage;
    final data = await firestoreRef
        .collection('room')
        .where('userId', isEqualTo: user.uid)
        .where('type', isEqualTo: _selectedRoomType)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        if (int.parse(doc['price']) < bookingPrice) {
          String id = doc.id;
          roomsId.add(id);
        }
      });
    });
    final snapshot =
        await FirebaseFirestore.instance.collection('booking').get();
    if (snapshot.size == 0) {
      for (var i = 0; i < roomsId.length; i++) {
        String temp = roomsId[i];
        availabeRooms.add(temp);
      }
    } else {
      for (var i = 0; i < roomsId.length; i++) {
        await firestoreRef
            .collection('booking')
            .where('roomId', isEqualTo: roomsId[i])
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((doc) async {
            if (await checkStatus(roomsId[i]) == 'Available') {
              String availabeRoomsId = roomsId[i];
              if (!availabeRooms.contains(availabeRoomsId)) {
                availabeRooms.add(availabeRoomsId);
              }
            } else {
              notAvailableRooms.add(roomsId[i]);
            }
          });
        });
      }
      for (var i = 0; i < roomsId.length; i++) {
        await firestoreRef
            .collection('booking')
            .where('roomId', isNotEqualTo: roomsId[i])
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((doc) {
            String availabeRoomsIdWithoutDate = roomsId[i];
            if (!availabeRooms.contains(availabeRoomsIdWithoutDate) &&
                !notAvailableRooms.contains(availabeRoomsIdWithoutDate)) {
              availabeRooms.add(availabeRoomsIdWithoutDate);
            }
          });
        });
      }
    }
    DateTime dateBookingArrival =
        DateFormat("yyyy-MM-dd").parse(dateinputArrival.text);
    DateTime dateBookingDeparture =
        DateFormat("yyyy-MM-dd").parse(dateinputDeparture.text);
    Timestamp convertBookingArrival = _dateTimeToTimestamp(dateBookingArrival);
    Timestamp convertBookingDeparture =
        _dateTimeToTimestamp(dateBookingDeparture);
    if (enteredTextField1.trim().isEmpty) {
      errorMessage = 'Service\'s ID must not be empty.';
    } else if (enteredTextField2.trim().isEmpty) {
      errorMessage = 'Date Arrival must not be empty.';
    } else if (enteredTextField3.trim().isEmpty) {
      errorMessage = 'Date departure must not be empty';
    }
    if (errorMessage != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Alert'),
          content: Text(errorMessage),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context); // close AlertDialog
                },
                child: const Text('Close'))
          ],
        ),
      );
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FindRoomScreen(
                roomId: availabeRooms,
                guestId: guestId,
                dateArrival: convertBookingArrival,
                dateDeparture: convertBookingDeparture,
                roomPrice: bookingPrice,
                roomType: _selectedRoomType)));
    _textField1Controller.clear();
    _textField4Controller
        .clear(); // show SnackBar that room was created successfully and clear the TextField
  }
  // FindRoomScreen(roomId: availabeRooms, gu guestId, convertBookingArrival, convertBookingDeparture, bookingPrice, _selectedRoomType)

  Future<DateTime> getDateArrival(roomId) async {
    Timestamp arrival, departure;
    late DateTime dateOfArrival;
    // , dateOfDeparture;
    await firestoreRef
        .collection('booking')
        .where('roomId', isEqualTo: roomId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        arrival = doc['arrival'];
        dateOfArrival = arrival.toDate();
        // departure = doc['departure'];
        // dateOfDeparture = departure.toDate();
      });
    });
    return dateOfArrival;
  }

  Future<DateTime> getDateDeparture(String roomId) async {
    Timestamp arrival, departure;
    late DateTime dateOfDeparture;
    // , dateOfDeparture;
    await firestoreRef
        .collection('booking')
        .where('roomId', isEqualTo: roomId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        // arrival = doc['arrival'];
        // dateOfArrival = arrival.toDate();
        departure = doc['departure'];
        dateOfDeparture = departure.toDate();
      });
    });
    return dateOfDeparture;
  }

  Future<String> checkStatus(String roomId) async {
    // final now = DateTime.now();
    DateTime dateCheckBookingArrival =
        DateFormat("yyyy-MM-dd").parse(dateinputArrival.text);
    DateTime dateCheckBookingDeparture =
        DateFormat("yyyy-MM-dd").parse(dateinputDeparture.text);
    DateTime dateOfArrival = await getDateArrival(roomId);
    DateTime dateOfDeparture = await getDateDeparture(roomId);

    if (dateCheckBookingArrival.compareTo(dateOfArrival) < 0) {
      if (dateCheckBookingDeparture.compareTo(dateOfArrival) < 0) {
        return 'Available';
      }
      return 'Not available';
    } else {
      if (dateCheckBookingArrival.compareTo(dateOfDeparture) > 0) {
        return 'Available';
      }
      return 'Not available';
    }
  }

  Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
  }

  @override
  void initState() {
    dateinputArrival.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'Booking detail',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: _textField1Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20.0,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      hintText: 'Enter guest\'s id',
                      hintStyle: TextStyle(fontSize: 18.0),
                      prefixIcon: Icon(
                        Icons.key,
                        size: 30.0,
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: dateinputArrival,
                    // keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      hintText: 'Enter date of arrival',
                      hintStyle: const TextStyle(fontSize: 18.0),
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        size: 30.0,
                      ),
                      filled: true,
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? arrivalPickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2030),
                        initialEntryMode: DatePickerEntryMode.input,
                        helpText: 'Select arrival date',
                      );
                      if (arrivalPickedDate != null &&
                          arrivalPickedDate != DateTime.now()) {
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final String formatted =
                            formatter.format(arrivalPickedDate);
                        // String formatDate = DateFormat.yMd().format(pickedDate);
                        setState(() {
                          dateinputArrival.text = formatted;
                        });
                      }
                    },
                    //onSubmitted :
                  ),
                  const SizedBox(height: 30),
                  TextField(
                      controller: dateinputDeparture,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                        ),
                        hintText: 'Enter date of departure',
                        hintStyle: const TextStyle(fontSize: 18.0),
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          size: 30.0,
                        ),
                        filled: true,
                      ),
                      readOnly: true,
                      onTap: () async {
                        if (dateinputArrival.text.isNotEmpty) {
                          String dateTime = dateinputArrival.text;
                          DateFormat inputFormat = DateFormat('yyyy-MM-dd');
                          DateTime input = inputFormat.parse(dateTime);
                          DateTime? departurePickeDate = await showDatePicker(
                              context: context,
                              initialDate: input.add(const Duration(days: 1)),
                              firstDate: input.add(const Duration(days: 1)),
                              lastDate: DateTime(2100),
                              initialEntryMode: DatePickerEntryMode.input,
                              helpText: 'Select departure date');

                          if (departurePickeDate != null &&
                              departurePickeDate != DateTime.now()) {
                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');
                            final String formatted =
                                formatter.format(departurePickeDate);
                            // String formatDate = DateFormat.yMd().format(pickedDate);
                            setState(() {
                              dateinputDeparture.text = formatted;
                            });
                          }
                        }
                      }),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _textField4Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      hintText: 'Enter maximum price  (optional)',
                      hintStyle: const TextStyle(fontSize: 18.0),
                      prefixIcon: Icon(
                        Icons.monetization_on,
                        size: 30.0,
                      ),
                      filled: true,
                    ),
                    //onSubmitted :
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.category,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: DropdownButton(
                            underline: SizedBox(),
                            value: _selectedRoomType,
                            items: roomType
                                .map((data) => DropdownMenuItem(
                                    value: data,
                                    child: Row(
                                      children: [
                                        Text(
                                          data,
                                        ),
                                      ],
                                    )))
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedRoomType = value;
                              });
                            },
                            // style: ,
                            // isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        findBooking();
                      },
                      child: const Text(
                        'LOOK FOR A ROOM',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
