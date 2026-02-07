import 'package:delivery_app/constants/nav_bar.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColorLight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('DE',style: TextStyle(fontSize: 25),),
              ),

            ),
            SizedBox(height: 10,),
            Text('Davidson Edgar', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),
            SizedBox(height: 20,),
            Divider(),

            ProfileOptions(text: 'Payments', icon: Icons.payment),
            ProfileOptions(text: 'Delivery History', icon: Icons.restore),
            ProfileOptions(text: 'Settings', icon: Icons.settings),
            ProfileOptions(text: 'Support/FAQ', icon: Icons.contact_support),
            ProfileOptions(text: 'Invite Friends', icon: Icons.attach_email_sharp),
            Spacer(),
            ProfileOptions(text: 'Sign out', icon: Icons.logout)
          ],
        ),
      ),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  final String text;
  final IconData icon;

  const ProfileOptions({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(children: [Icon(icon,color: icon == Icons.logout? colorRed:lightBlack,), SizedBox(width: 10), Text(text)]),
    );
  }
}
