import 'package:delivery_app/constants/colors.dart';
import 'package:delivery_app/constants/nav_bar.dart';
import 'package:delivery_app/history/history_details.dart';
import 'package:delivery_app/history/history_screen.dart';
import 'package:delivery_app/home/components/google_maps.dart';
import 'package:delivery_app/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: CustomBottomNavBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 30,
              right: 30,
              bottom: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text('Welcome Back', style: TextStyle(fontSize: 12)),
                        Text('Davidson Edgar', style: TextStyle(fontSize: 16)),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(Icons.notification_add),
                        SizedBox(width: 5),

                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColorLight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('DE'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 30),

                Text(
                  'What would you like to do?',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(height: 10),

                CustomCard(
                  icon: Icons.electric_bolt_outlined,
                  text: 'Instant Delivery',
                  subText:
                      'Courier takes only your package and delivers instantly',
                  color: primaryColorLight,
                  isScheduledDelivery: false,
                ),
                CustomCard(
                  icon: Icons.timer_outlined,
                  text: 'Schedule Delivery',
                  subText:
                      'Courier comes to pick up on your specified date and time',
                  color: background,
                  isScheduledDelivery: true,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: 3,

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
        ],
      ),
    );
  }
}

class HistoryDetailsCard extends StatelessWidget {
  const HistoryDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryDetails()),
        );
      },
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORD1234',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Recipient: Paul Pogba',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryDetails(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: greenColor,
                        foregroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Text('Completed', style: TextStyle(fontSize: 10)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.motorcycle, color: primaryColor),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 10,
                            color: primaryColor,
                          ),
                          Text(
                            'Drop Off',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        'Maryland bustop, Antony Ikeja',
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '12 January 2026, 2:43pm',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 20),
          Divider(),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String? text;
  final String? subText;
  final Color? color;
  final bool isScheduledDelivery;

  const CustomCard({
    super.key,
    this.text,
    this.color,
    required this.icon,
    this.subText,
    required this.isScheduledDelivery,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DataProvider>().setIsScheduledDelivery(isScheduledDelivery);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleMaps()),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: color,
        child: Stack(
          children: [
            Positioned(
              right: 2,
              child: Icon(
                icon,
                size: 120,
                color: lightBlack.withValues(alpha: 0.15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(icon, color: primaryColor, size: 35),
                  Text(
                    text ?? '',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subText ?? '',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
