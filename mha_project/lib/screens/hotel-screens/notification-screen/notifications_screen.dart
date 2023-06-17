import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final List<String> serviceType = [
  "CLEAN UP",
  "LAUNDRY",
  "RECEPTION",
  "LUGGAGE",
  "Food & Beverage",
  "TRANSPORT",
  "CALLING",
];

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _textField1Controller = TextEditingController();
  final _textField2Controller = TextEditingController();
  var _selectedServiceType = serviceType[0];

  bool isTextFieldNumberValid(String text) {
    if (double.tryParse(text) == null) {
      return false;
    }
    if (double.tryParse(text)! < 0) {
      return false;
    }
    return true;
  }

  void _submitAddService(BuildContext context) async {
    final enteredTextField1 = _textField1Controller.text;
    final enteredTextField2 = _textField2Controller.text;

    // if (widget.categoryName == 'room') {
    //   enteredTextField2 = double.tryParse(_textField2Controller.text);
    //   enteredTextField3 = double.tryParse(_textField3Controller.text);
    // } else {
    //   enteredTextField2 = _textField2Controller.text;
    //   enteredTextField3 = _textField3Controller.text;
    // }
    // if (widget.categoryName == 'room' || widget.categoryName == 'service') {
    //   enteredTextField4 = double.tryParse(_textField4Controller.text);
    // } else {
    //   enteredTextField4 = _textField4Controller.text;
    // }

    // print(enteredTextField1);
    // print(enteredTextField2);
    // print(enteredTextField3);
    // print(enteredTextField4);

    var errorMessage;

    if (enteredTextField1.trim().isEmpty) {
      errorMessage = 'Service\'s ID must not be empty.';
    } else if (enteredTextField2.trim().isEmpty) {
      errorMessage = 'Guest\'s ID must not be empty.';
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
    try {
      final user = await FirebaseAuth.instance.currentUser!;
      CollectionReference roomRef =
          FirebaseFirestore.instance.collection('add_service');
      DocumentReference newRoomRef =
          roomRef.doc(); // this will generate a custom id for each new document

      // String newUserID = newRoomRef.id;
      // print(newUserID);
      newRoomRef.set(
        {
          'userId': user.uid,
          'serviceId': enteredTextField1,
          'guestId': enteredTextField2,
          'type': _selectedServiceType,
        },
      );

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully add service for a room'),
        ),
      );
      _textField1Controller.clear();
      _textField2Controller
          .clear(); // show SnackBar that room was created successfully and clear the TextField
      FocusScope.of(context).unfocus();
    } on FirebaseAuthException catch (error) {
      print(error);
    }
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
                      'Add Service',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: _textField1Controller,
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
                      hintText: 'Enter service\'s id',
                      hintStyle: TextStyle(fontSize: 18.0),
                      prefixIcon: Icon(
                        Icons.key,
                        size: 30.0,
                      ),
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _textField2Controller,
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
                        Icons.person,
                        size: 30.0,
                      ),
                      filled: true,
                    ),
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
                            value: _selectedServiceType,
                            items: serviceType
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
                                _selectedServiceType = value;
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
                        _submitAddService(context);
                      },
                      child: const Text(
                        'ADD SERVICE FOR CUSTOMER',
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
