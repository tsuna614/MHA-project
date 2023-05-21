import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// const ROOM_COLLECTION_NAME = 'rooms';

final user = FirebaseAuth.instance.currentUser!;

final List<String> serviceType = [
  "CLEAN UP",
  "ROOM SERVICE",
  "RECEPTION",
  "LUGGAGE",
  "BREAKFAST",
  "TRANSPORT",
  // DropDownValueModel(name: 'CLEAN UP', value: "CLEAN UP"),
  // DropDownValueModel(name: 'ROOM SERVICE', value: "ROOM SERVICE"),
  // DropDownValueModel(name: 'LUGGAGE', value: "LUGGAGE"),
  // DropDownValueModel(name: 'BREAKFAST', value: "BREAKFAST"),
];

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _textField1Controller = TextEditingController();

  final _textField2Controller = TextEditingController();

  final _textField3Controller = TextEditingController();

  final _textField4Controller = TextEditingController();

  var _selectedType = serviceType[0];

  bool isTextFieldNumberValid(String text) {
    if (double.tryParse(text) == null) {
      return false;
    }
    if (double.tryParse(text)! < 0) {
      return false;
    }
    return true;
  }

  void _submitCreateRoom(BuildContext context) async {
    final enteredTextField1 = _textField1Controller.text;
    final enteredTextField2 = _textField2Controller.text;
    final enteredTextField3 = _textField3Controller.text;
    final enteredTextField4 = _textField4Controller.text;

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

    if (widget.categoryName == 'room') {
      if (enteredTextField1.trim().isEmpty) {
        errorMessage = 'Room\'s address must not be empty.';
      } else if (enteredTextField2.trim().isEmpty ||
          !isTextFieldNumberValid(enteredTextField2)) {
        errorMessage = 'Room\'s floor must be a valid number.';
      } else if (enteredTextField3.trim().isEmpty ||
          !isTextFieldNumberValid(enteredTextField3)) {
        errorMessage = 'Room\'s number of beds must be a valid number.';
      } else if (enteredTextField4.trim().isEmpty ||
          !isTextFieldNumberValid(enteredTextField4)) {
        errorMessage = 'Room\'s price must be a valid number.';
      }
    } else if (widget.categoryName == 'service') {
      if (enteredTextField1.trim().isEmpty) {
        errorMessage = 'Service\'s ID must not be empty.';
      } else if (enteredTextField2.trim().isEmpty) {
        errorMessage = 'Service\'s name must not be empty.';
      } else if (enteredTextField3.trim().isEmpty) {
        errorMessage = 'Service\'s phone number must not be empty.';
      } else if (enteredTextField4.trim().isEmpty ||
          !isTextFieldNumberValid(enteredTextField4)) {
        errorMessage = 'Service\'s price must be a valid number.';
      }
    } else if (widget.categoryName == 'employee') {
      if (enteredTextField1.trim().isEmpty) {
        errorMessage = 'Employee\'s ID must not be empty.';
      } else if (enteredTextField2.trim().isEmpty) {
        errorMessage = 'Employee\'s name must not be empty.';
      } else if (enteredTextField3.trim().isEmpty) {
        errorMessage = 'Employee\'s phone number must not be empty.';
      } else if (enteredTextField4.trim().isEmpty) {
        errorMessage = 'Employee\'s email must not be empty.';
      }
    } else {
      if (enteredTextField1.trim().isEmpty) {
        errorMessage = 'Customer\'s ID must not be empty.';
      } else if (enteredTextField2.trim().isEmpty) {
        errorMessage = 'Customer\'s name must not be empty.';
      } else if (enteredTextField3.trim().isEmpty) {
        errorMessage = 'Customer\'s phone number must not be empty.';
      } else if (enteredTextField4.trim().isEmpty) {
        errorMessage = 'Customer\'s email must not be empty.';
      }
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
      CollectionReference roomRef =
          FirebaseFirestore.instance.collection(widget.categoryName);
      DocumentReference newRoomRef =
          roomRef.doc(); // this will generate a custom id for each new document

      // String newUserID = newRoomRef.id;
      // print(newUserID);
      switch (widget.categoryName) {
        case 'room':
          await newRoomRef.set(
            {
              'userId': user.uid,
              'address': enteredTextField1,
              'floor': enteredTextField2,
              'beds': enteredTextField3,
              'price': enteredTextField4
            },
          );
          break;
        case 'service':
          await newRoomRef.set(
            {
              'userId': user.uid,
              'id': enteredTextField1,
              'name': enteredTextField2,
              'number': enteredTextField3,
              'price': enteredTextField4,
              'type': _selectedType
            },
          );
          break;
        case 'employee':
          await newRoomRef.set(
            {
              'userId': user.uid,
              'id': enteredTextField1,
              'name': enteredTextField2,
              'number': enteredTextField3,
              'email': enteredTextField4
            },
          );
          break;
        case 'customer':
          await newRoomRef.set(
            {
              'userId': user.uid,
              'id': enteredTextField1,
              'name': enteredTextField2,
              'number': enteredTextField3,
              'email': enteredTextField4
            },
          );
          break;
      }
      // store the data on the firebase firestore

      if (context.mounted) {
        var successMessage = '';
        switch (widget.categoryName) {
          case 'room':
            successMessage = 'Successfully created a new room';
            break;
          case 'service':
            successMessage = 'Successfully created a new service';
            break;
          case 'employee':
            successMessage = 'Successfully created a new employee';
            break;
          case 'customer':
            successMessage = 'Successfully created a new customer';
            break;
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(successMessage),
          ),
        );
        _textField1Controller.clear();
        _textField2Controller.clear();
        _textField3Controller.clear();
        _textField4Controller.clear();
      } // show SnackBar that room was created successfully and clear the TextField
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBarTitle;
    var textField1HintText;
    var textField2HintText;
    var textField3HintText;
    var textField4HintText;
    var textField1Icon;
    var textField2Icon;
    var textField3Icon;
    var textField4Icon;

    if (widget.categoryName == 'room') {
      appBarTitle = 'CREATE ROOM';
      textField1HintText = 'Room\'s address';
      textField2HintText = 'Room\'s floor';
      textField3HintText = 'Number of beds';
      textField4HintText = 'Room\'s price (per night)';
      textField1Icon = Icons.door_back_door;
      textField2Icon = Icons.stairs;
      textField3Icon = Icons.bed;
      textField4Icon = Icons.attach_money;
    } else if (widget.categoryName == 'service') {
      appBarTitle = 'CREATE SERVICE';
      textField1HintText = 'Service\'s ID';
      textField2HintText = 'Service\'s name';
      textField3HintText = 'Phone number';
      textField4HintText = 'Service\'s price';
      textField1Icon = Icons.key;
      textField2Icon = Icons.work;
      textField3Icon = Icons.phone;
      textField4Icon = Icons.attach_money;
    } else if (widget.categoryName == 'employee') {
      appBarTitle = 'CREATE EMPLOYEE';
      textField1HintText = 'Employee\'s ID';
      textField2HintText = 'Employee\'s fullname';
      textField3HintText = 'Employee\'s number';
      textField4HintText = 'Employee\'s email';
      textField1Icon = Icons.key;
      textField2Icon = Icons.person;
      textField3Icon = Icons.phone;
      textField4Icon = Icons.mail;
    } else {
      appBarTitle = 'CREATE CUSTOMER';
      textField1HintText = 'Customer\'s ID';
      textField2HintText = 'Customer\'s fullname';
      textField3HintText = 'Customer\'s number';
      textField4HintText = 'Customer\'s email';
      textField1Icon = Icons.key;
      textField2Icon = Icons.person;
      textField3Icon = Icons.phone;
      textField4Icon = Icons.mail;
    }

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 30, right: 30, top: 50, bottom: keyboardSpace),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      (() {
                        if (widget.categoryName == 'room') {
                          return 'Room\'s detail';
                        } else if (widget.categoryName == 'service') {
                          return 'Service\'s detail';
                        } else if (widget.categoryName == 'employee') {
                          return 'Employee\'s detail';
                        }
                        return 'Customer\'s detail';
                      }()),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
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
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      hintText: textField1HintText,
                      hintStyle: TextStyle(fontSize: 18.0),
                      prefixIcon: Icon(
                        textField1Icon,
                        size: 30.0,
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _textField2Controller,
                    keyboardType: widget.categoryName == 'room'
                        ? TextInputType.number
                        : TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      hintText: textField2HintText,
                      hintStyle: const TextStyle(fontSize: 18.0),
                      prefixIcon: Icon(
                        textField2Icon,
                        size: 30.0,
                      ),
                      filled: true,
                    ),
                    //onSubmitted :
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _textField3Controller,
                    keyboardType: widget.categoryName == 'room'
                        ? TextInputType.number
                        : TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      hintText: textField3HintText,
                      hintStyle: const TextStyle(fontSize: 18.0),
                      prefixIcon: Icon(
                        textField3Icon,
                        size: 30.0,
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textField4Controller,
                          keyboardType: widget.categoryName == 'room' ||
                                  widget.categoryName == 'service'
                              ? TextInputType.number
                              : TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15.0),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                            ),
                            hintText: textField4HintText,
                            hintStyle: const TextStyle(fontSize: 18.0),
                            prefixIcon: Icon(
                              textField4Icon,
                              size: 30.0,
                            ),
                            filled: true,
                          ),
                          //onSubmitted :
                        ),
                      ),
                      if (widget.categoryName == 'service')
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: DropdownButton(
                              value: _selectedType,
                              items: serviceType
                                  .map((data) => DropdownMenuItem(
                                      value: data, child: Text(data)))
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedType = value;
                                });
                              },
                              // style: ,
                              isExpanded: true,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
