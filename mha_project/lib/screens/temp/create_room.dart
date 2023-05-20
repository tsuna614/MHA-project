// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key, required this.categoryName});

  final String categoryName;

  final _textField1Controller = TextEditingController();
  final _textField2Controller = TextEditingController();
  final _textField3Controller = TextEditingController();
  final _textField4Controller = TextEditingController();

  void _submitCreateRoom(BuildContext context) async {
    final enteredAddress = _textField1Controller.text;
    final enteredFloor = double.tryParse(_textField2Controller.text);
    final enteredBeds = double.tryParse(_textField3Controller.text);
    final enteredPrice = double.tryParse(_textField4Controller.text);

    // print(enteredAddress);
    // print(enteredFloor);
    // print(enteredBeds);
    // print(enteredPrice);

    var errorMessage;

    if (enteredAddress.trim().isEmpty) {
      errorMessage = 'Room\'s address must not be empty.';
    } else if (enteredFloor == null || enteredFloor < 0) {
      errorMessage = 'Room\'s floor must be a valid number.';
    } else if (enteredBeds == null || enteredFloor < 0) {
      errorMessage = 'Room\'s number of beds must be a valid number.';
    } else if (enteredPrice == null || enteredFloor < 0) {
      errorMessage = 'Room\'s price must be a valid number.';
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
          FirebaseFirestore.instance.collection('rooms');
      DocumentReference newRoomRef =
          roomRef.doc(); // this will generate a custom id for each new document

      // String newUserID = newRoomRef.id;
      // print(newUserID);

      await newRoomRef.set(
        {
          'address': enteredAddress,
          'floor': enteredFloor,
          'beds': enteredBeds,
          'price': enteredPrice
        },
      ); // store the data on the firebase firestore

      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully created a new room'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (() {
            if (categoryName == 'room') {
              return 'CREATE ROOM';
            } else if (categoryName == 'service') {
              return 'CREATE SERVICE';
            } else if (categoryName == 'employee') {
              return 'CREATE EMPLOYEE';
            }
            return 'CREATE CUSTOMER';
          }()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Room\'s detail:',
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
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: 'Room\'s address',
                hintStyle: const TextStyle(fontSize: 18.0),
                prefixIcon: const Icon(
                  Icons.door_back_door,
                  size: 30.0,
                ),
                filled: true,
              ),
              //onSubmitted :
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _textField2Controller,
              decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: 'Room\'s floor',
                hintStyle: const TextStyle(fontSize: 18.0),
                prefixIcon: const Icon(
                  Icons.stairs,
                  size: 30.0,
                ),
                filled: true,
              ),
              //onSubmitted :
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _textField3Controller,
              decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: 'Number of beds',
                hintStyle: const TextStyle(fontSize: 18.0),
                prefixIcon: const Icon(
                  Icons.bed,
                  size: 30.0,
                ),
                filled: true,
              ),
              //onSubmitted :
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _textField4Controller,
              decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: 'Room\'s price (per night)',
                hintStyle: const TextStyle(fontSize: 18.0),
                prefixIcon: const Icon(
                  Icons.attach_money,
                  size: 30.0,
                ),
                filled: true,
              ),
              //onSubmitted :
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    _submitCreateRoom(context);
                  },
                  child: const Text('CREATE')),
            ),
          ],
        ),
      ),
    );
  }
}
