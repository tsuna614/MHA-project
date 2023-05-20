import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel_screens/manage_screens/manage_button.dart';

class ManageCard extends StatelessWidget {
  const ManageCard(
      {super.key, required this.categoryName, required this.categoryImage});
  final Image categoryImage;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    ManageButton(
                        buttonName: 'Create',
                        categoryName: categoryName,
                        buttonColor: Color.fromARGB(255, 105, 156, 252)),
                    ManageButton(
                      buttonName: 'View',
                      categoryName: categoryName,
                      buttonColor: Color.fromARGB(255, 107, 204, 253),
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






 
    // return Container(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(5.0),
    //                             child: Column(
    //                               // mainAxisAlignment:
    //                               // MainAxisAlignment.spaceEvenly,
    //                               children: <Widget>[
    //                                 Container(
    //                                   child: const Text(
    //                                     'Services',
    //                                     style: TextStyle(
    //                                       fontWeight: FontWeight.bold,
    //                                       fontSize: 20,
    //                                       letterSpacing: 3.0,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   child: Column(
    //                                     // crossAxisAlignment:
    //                                     //     // CrossAxisAlignment.stretch,
    //                                     children: <Widget>[
    //                                       ElevatedButton(
    //                                         onPressed: () {
    //                                           Navigator.push(
    //                                             context,
    //                                             MaterialPageRoute(
    //                                                 builder: (context) =>
    //                                                     Create_Services_Screen()),
    //                                           );
    //                                         },
    //                                         style: ElevatedButton.styleFrom(
    //                                             backgroundColor: const Color.fromARGB(
    //                                                 255, 137, 207, 240),
    //                                             minimumSize:
    //                                                 const Size(35.0, 30.0)),
    //                                         child: const Text(
    //                                           'Create Services',
    //                                           style: TextStyle(
    //                                               color: Colors.white),
    //                                         ),
    //                                       ),
    //                                       ElevatedButton(
    //                                         onPressed: () {
    //                                           Navigator.push(
    //                                               context,
    //                                               MaterialPageRoute(
    //                                                   builder: (context) =>
    //                                                       View_Services_Screen()));
    //                                         },
    //                                         style: ElevatedButton.styleFrom(
    //                                             backgroundColor: const Color.fromARGB(
    //                                                 255, 137, 207, 240),
    //                                             minimumSize:
    //                                                 const Size(35.0, 30.0)),
    //                                         child: const Text(
    //                                           'View Services',
    //                                           style: TextStyle(
    //                                               color: Colors.white),
    //                                         ),
    //                                       ),
    //                                       ElevatedButton(
    //                                         onPressed: () {
    //                                           Navigator.push(
    //                                               context,
    //                                               MaterialPageRoute(
    //                                                   builder: (context) =>
    //                                                       Delete_Services_Screen()));
    //                                         },
    //                                         style: ElevatedButton.styleFrom(
    //                                             primary: Color.fromARGB(
    //                                                 255, 137, 207, 240),
    //                                             minimumSize:
    //                                                 const Size(25.0, 30.0)),
    //                                         child: Text(
    //                                           'Delete Services',
    //                                           style: TextStyle(
    //                                               color: Colors.white),
    //                                         ),
    //                                       )
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                         ClipRRect(
    //                             borderRadius: BorderRadius.circular(10.0),
    //                             child: Container(
    //                               height: 130,
    //                               width: 150,
    //                               child: Image.asset('assets/service.jpg',
    //                                   fit: BoxFit.cover),
    //                             ))
    //                       ],
    //                     ))),;

