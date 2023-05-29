import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/manage-screens/manage_button.dart';

class ManageCard extends StatelessWidget {
  const ManageCard(
      {super.key, required this.categoryName, required this.categoryImage});
  final Image categoryImage;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(128, 196, 194, 194),
              blurRadius: 4,
              offset: Offset(4, 8),
            )
          ]),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              '${categoryName}'.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                letterSpacing: 5.0,
              ),
            ),
          ),
          Container(
            child: Column(children: [
              Container(
                  padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: categoryImage,
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                        child: ManageButton(
                          buttonName: 'Create',
                          categoryName: categoryName,
                          buttonColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                        child: ManageButton(
                          buttonName: 'View',
                          categoryName: categoryName,
                          buttonColor: Color.fromARGB(255, 115, 208, 255),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
