import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/home-screen/chart/bar_chart.dart';
import 'package:mha_project/screens/hotel-screens/home-screen/info_card.dart';
import 'package:mha_project/screens/hotel-screens/home-screen/report_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            // margin: const EdgeInsets.only(bottom: 20.0),
            alignment: Alignment.topCenter,
            height: 125.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ), // orange block below dashboard
          InfoCard(),
          Padding(
            padding: EdgeInsets.only(top: 180),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(height: 10),
                  GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 columns
                            childAspectRatio: 10 / 9,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    // 20px spacing horizontally and vertically between grid items
                    children: const [
                      ReportCard(
                        cardColor: Colors.green,
                        cardType: 'income',
                      ),
                      ReportCard(
                        cardColor: Colors.red,
                        cardType: 'revenue',
                      ),
                      ReportCard(
                        cardColor: Colors.purple,
                        cardType: 'occupancy',
                      ),
                      ReportCard(
                        cardColor: Colors.orange,
                        cardType: 'guest',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 3,
                    width: 200,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  SizedBox(height: 50),
                  SizedBox(height: 400, child: MyBarChart()),
                  SizedBox(height: 20),
                  Text(
                    'Weekly Revenue',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
