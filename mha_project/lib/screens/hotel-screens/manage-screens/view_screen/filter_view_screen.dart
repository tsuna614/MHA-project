import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterList extends StatelessWidget {
  const FilterList({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled:
                  true, // this line will make the bottom sheet go all the way up (show full of its height)
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
              ),
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Title(
                            color: Colors.black,
                            child: Text(
                              'FILTER',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0),
                            )),
                      ],
                    ),
                  ),
                );
              });
        },
        icon: Icon(
          Icons.filter_list,
          color: Colors.white,
        ));
  }
}
