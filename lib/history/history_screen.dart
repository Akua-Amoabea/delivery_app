import 'package:delivery_app/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/nav_bar.dart';
import '../home/home_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: CustomBottomNavBar(),

      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 30, right: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery History', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 8,

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    child: HistoryDetailsCard(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
