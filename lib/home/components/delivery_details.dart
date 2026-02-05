import 'package:delivery_app/constants/colors.dart';
import 'package:delivery_app/home/components/google_maps.dart';
import 'package:delivery_app/provider/data_provider.dart';
import 'package:delivery_app/widgets/custom_text_button.dart';
import 'package:delivery_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatelessWidget {
  const DeliveryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'What are you sending',
                /* style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),*/
              ),

              Text('Select type of item(eg.gadget, document)'),
              CustomTextField(hintText: 'Select'),
              Text('Quantity'),
              CustomTextField(hintText: '5'),

              Text('Select who pays'),
              Row(
                children: [
                  Radio<String>(
                    value: "Me",
                    activeColor: primaryColor,
                    groupValue: context.watch<DataProvider>().selectedOption,
                    onChanged: (v) => dataProvider.setOption(v!),
                  ),

                  const Text("Me"),

                  Radio<String>(
                    value: "Recipient",
                    activeColor: primaryColor,

                    groupValue: context.watch<DataProvider>().selectedOption,
                    onChanged: (v) => dataProvider.setOption(v!),
                  ),
                  const Text("Recipient"),
                ],
              ),

              Text('Recipient Names'),
              CustomTextField(hintText: 'Donald Duck'),
              Text('Recipient Contact Number'),
              CustomTextField(hintText: '+233 30939493'),

              // CustomTextField(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Take a picture of the package',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [CustomTextButton(text: 'Order', onPressed: () {
                  dataProvider.setIsOrdered(true);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> GoogleMaps()));
                })],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
