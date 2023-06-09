import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/create_screen.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/view_screen/view_screen.dart';

class ManageButton extends StatelessWidget {
  const ManageButton(
      {super.key,
      required this.buttonName,
      required this.categoryName,
      required this.buttonColor});
  final String buttonName, categoryName;
  final Color buttonColor;
  void navigateScreen(BuildContext context) {
    if (buttonName == 'Create') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateScreen(categoryName: categoryName)));
    } else if (buttonName == 'View') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewScreen(categoryName: categoryName)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        navigateScreen(context);
      },
      child: Text(buttonName, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        // minimumSize: const Size(80.0, 40.0),
      ),
    );
  }
}
