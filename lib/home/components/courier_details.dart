import 'package:delivery_app/constants/colors.dart';
import 'package:delivery_app/provider/data_provider.dart';
import 'package:delivery_app/widgets/controller_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

class CourierDetails extends StatelessWidget {
  CourierDetails({super.key});

  final ControllerManager _controllerManager = ControllerManager();

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your courier is on his way!',
                style: TextStyle(color: primaryColor),
              ),
              Text('2 mins away'),
            ],
          ),

          SizedBox(height: 14),

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
                      Text('124 Deliveries', style: TextStyle(fontSize: 11)),
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
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.call),
                style: IconButton.styleFrom(foregroundColor: primaryColor),
              ),
            ],
          ),
          SizedBox(height: 25),

          GestureDetector(
            onTap: () {
              dataProvider.resetSelection();
              dataProvider.setIsOrdered(false);
              dataProvider.setIsSubmitted(false);


            },
            child: Center(
              child: Text('Cancel', style: TextStyle(color: colorRed)),
            ),
          ),
        ],
      ),
    );
  }
}
