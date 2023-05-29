// import 'package:flutter/material.dart';

// class BookingScreen extends StatelessWidget {
//   const BookingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             minWidth: MediaQuery.of(context).size.width,
//             minHeight: MediaQuery.of(context).size.height,
//           ),
//           child: IntrinsicHeight(
//             child: Padding(
//               padding: EdgeInsets.only(
//                   left: 30, right: 30, top: 50, bottom: keyboardSpace),
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 30),
//                     child: Text(
//                       'Booking detail',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).primaryColor),
//                     ),
//                   ),
//                   const SizedBox(height: 50),
//                   TextField(
//                     controller: _textField1Controller,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       contentPadding:
//                           const EdgeInsets.symmetric(vertical: 15.0),
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(
//                             20.0,
//                           ),
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Theme.of(context).primaryColor),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(20.0)),
//                       ),
//                       hintText: textField1HintText,
//                       hintStyle: TextStyle(fontSize: 18.0),
//                       prefixIcon: Icon(
//                         textField1Icon,
//                         size: 30.0,
//                       ),
//                       filled: true,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   TextField(
//                     controller: _textField2Controller,
//                     keyboardType: widget.categoryName == 'room'
//                         ? TextInputType.number
//                         : TextInputType.text,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       contentPadding:
//                           const EdgeInsets.symmetric(vertical: 15.0),
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Theme.of(context).primaryColor),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(20.0)),
//                       ),
//                       hintText: textField2HintText,
//                       hintStyle: const TextStyle(fontSize: 18.0),
//                       prefixIcon: Icon(
//                         textField2Icon,
//                         size: 30.0,
//                       ),
//                       filled: true,
//                     ),
//                     //onSubmitted :
//                   ),
//                   const SizedBox(height: 30),
//                   TextField(
//                     controller: _textField3Controller,
//                     keyboardType: widget.categoryName == 'room'
//                         ? TextInputType.number
//                         : TextInputType.text,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       contentPadding:
//                           const EdgeInsets.symmetric(vertical: 15.0),
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Theme.of(context).primaryColor),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(20.0)),
//                       ),
//                       hintText: textField3HintText,
//                       hintStyle: const TextStyle(fontSize: 18.0),
//                       prefixIcon: Icon(
//                         textField3Icon,
//                         size: 30.0,
//                       ),
//                       filled: true,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _textField4Controller,
//                           keyboardType: widget.categoryName == 'room' ||
//                                   widget.categoryName == 'service'
//                               ? TextInputType.number
//                               : TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             fillColor: Colors.white,
//                             contentPadding:
//                                 const EdgeInsets.symmetric(vertical: 15.0),
//                             enabledBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20.0)),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Theme.of(context).primaryColor),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(20.0)),
//                             ),
//                             hintText: textField4HintText,
//                             hintStyle: const TextStyle(fontSize: 18.0),
//                             prefixIcon: Icon(
//                               textField4Icon,
//                               size: 30.0,
//                             ),
//                             filled: true,
//                           ),
//                           //onSubmitted :
//                         ),
//                       ),
//                       if (widget.categoryName == 'room' ||
//                           widget.categoryName == 'service')
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 30, right: 30),
//                             child: DropdownButton(
//                               value: widget.categoryName == 'room'
//                                   ? _selectedRoomType
//                                   : _selectedServiceType,
//                               items: widget.categoryName == 'room'
//                                   ? roomType
//                                       .map((data) => DropdownMenuItem(
//                                           value: data, child: Text(data)))
//                                       .toList()
//                                   : serviceType
//                                       .map((data) => DropdownMenuItem(
//                                           value: data, child: Text(data)))
//                                       .toList(),
//                               onChanged: (value) {
//                                 if (value == null) {
//                                   return;
//                                 }
//                                 setState(() {
//                                   if (widget.categoryName == 'room')
//                                     _selectedRoomType = value;
//                                   else
//                                     _selectedServiceType = value;
//                                 });
//                               },
//                               // style: ,
//                               isExpanded: true,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   SizedBox(height: 100),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 60),
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size.fromHeight(40),
//                           backgroundColor: Theme.of(context).primaryColor,
//                         ),
//                         onPressed: () {
//                           _submitCreateRoom(context);
//                         },
//                         child: const Text('CREATE')),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
