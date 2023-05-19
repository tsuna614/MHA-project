import 'package:flutter/material.dart';

class CreateRoomScreen extends StatelessWidget {
  CreateRoomScreen({super.key});

  final _addressController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE ROOM'),
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
                'Booking detail:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              // controller: ,
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
              // controller: ,
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
              // controller: ,
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
              // controller: ,
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
          ],
        ),
      ),
    );
  }
}
