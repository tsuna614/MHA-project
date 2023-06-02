import 'package:flutter/material.dart';

final List<String> roomType = [
  "SINGLE",
  "DOUBLE",
  "QUAD",
  "QUEEN",
  "KING",
  "TWIN",
  "STUDIO",
  "SUITE",
  "APARTMENT",
  "VILLA",
];

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _textField1Controller = TextEditingController();
  final _textField2Controller = TextEditingController();
  final _textField3Controller = TextEditingController();
  final _textField4Controller = TextEditingController();

  var _selectedRoomType = roomType[0];

  void _submitCreateRoom(BuildContext context) {
    final enteredTextField1 = _textField1Controller.text;
    final enteredTextField2 = _textField2Controller.text;
    final enteredTextField3 = _textField3Controller.text;
    final enteredTextField4 = _textField4Controller.text;
    final selectedType = _selectedRoomType;

    print(enteredTextField1);
    print(enteredTextField2);
    print(enteredTextField3);
    print(enteredTextField4);
    print(selectedType);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

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
                    controller: _textField2Controller,
                    keyboardType: TextInputType.datetime,
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
                    //onSubmitted :
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _textField3Controller,
                    keyboardType: TextInputType.datetime,
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
                  ),
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
                      hintText: 'Enter maximum price',
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _submitCreateRoom(context);
                        },
                        child: const Text('CREATE')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
