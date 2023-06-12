import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.cardColor,
    required this.cardType,
  });

  final Color cardColor;
  final String cardType;

  @override
  Widget build(BuildContext context) {
    IconData reportCardIcon = Icons.error;
    var titleText = '';
    var mainText = '';

    void getType() {
      switch (cardType) {
        case 'income':
          reportCardIcon = Icons.monetization_on_outlined;
          titleText = 'Today\'s income';
          mainText = '1390.50';
          break;
        case 'revenue':
          reportCardIcon = Icons.meeting_room_outlined;
          titleText = 'Avg. revenue/room';
          mainText = '156.00';
          break;
        case 'occupancy':
          reportCardIcon = Icons.bed_outlined;
          titleText = 'Occupancy rate';
          mainText = '6.00';
          break;
        case 'guest':
          reportCardIcon = Icons.people;
          titleText = 'No. of guests';
          mainText = '15';
          break;
      }
    }

    getType();

    return Container(
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    reportCardIcon,
                    color: Colors.white,
                    size: 36,
                  ),
                  SizedBox(height: 20),
                  Text(
                    titleText,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    mainText,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
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
