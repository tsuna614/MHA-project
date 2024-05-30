// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     int timeElapsed = 0;
//     Timer timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
//       timeElapsed++;
//     });

//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             print(timeElapsed);
//           },
//           child: Text('Print time elapsed'),
//         ),
//       ),
//     );
//   }
// }
