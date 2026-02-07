import 'package:delivery_app/constants/colors.dart';
import 'package:delivery_app/home/home_screen.dart';
import 'package:delivery_app/profile/history_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: lightBlack),
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              Text('Home', style: TextStyle(color: lightBlack, fontSize: 12)),
            ],
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.calendar_month, color: lightBlack),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                },
              ),
              Text(
                'History',
                style: TextStyle(color: lightBlack, fontSize: 12),
              ),
            ],
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.person, color: lightBlack),
                onPressed: () {
                  // your action here
                },
              ),
              Text(
                'profile',
                style: TextStyle(color: lightBlack, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
