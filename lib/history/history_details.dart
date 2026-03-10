import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../constants/colors.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  SizedBox(width: 10),
                  Text('Delivery details', style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.person),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Allan Smith',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '124 Deliveries',
                            style: TextStyle(fontSize: 11),
                          ),
                          RatingStars(
                            value: 2,
                            starCount: 5,
                            starSize: 15,
                            maxValueVisibility: false,
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: [
                    Text(
                            'Completed',
                            style: TextStyle(fontSize: 14, color: primaryColor),
                          ),

                      SizedBox(width: 10),
                      Icon(Icons.motorcycle, color: primaryColor),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HistoryDetailsText(
                      text: 'Pickup Location',
                      subText: '32 Samwell Sq. Chevron',
                    ),
                    HistoryDetailsText(
                      text: 'Delivery Location',
                      subText: '21b, Karimu Kotun Street, Victoria',
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HistoryDetailsText(
                          text: 'What you are sending',
                          subText: 'Electronics/Gadgets',
                        ),
                        HistoryDetailsText(
                          text: 'Recipient',
                          subText: 'Donald Duck',
                        ),
                      ],
                    ),
                    HistoryDetailsText(
                      text: 'Recipient contact number ',
                      subText: '08123456789',
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HistoryDetailsText(text: 'Payment', subText: 'Card'),
                        HistoryDetailsText(text: 'Fee', subText: '¢150'),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup Image(s)',
                          style: TextStyle(color: lightBlack, fontSize: 12),
                        ),

                        SizedBox(height: 20),

                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Image(s)',
                          style: TextStyle(color: lightBlack, fontSize: 12),
                        ),

                        SizedBox(height: 20),

                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryDetailsText extends StatelessWidget {
  final String text;
  final String subText;

  const HistoryDetailsText({
    super.key,
    required this.text,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: TextStyle(color: lightBlack, fontSize: 12)),
        Text(subText, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 20),
      ],
    );
  }
}
