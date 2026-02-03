import 'package:delivery_app/login/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/logo_image.svg',
                  width: 130,
                ),
              ),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's get started",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Please input your details',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      Row(
                        children: [
                          Expanded(child: CustomTextField(hintText: 'First Name')),
                          SizedBox(width: 20),
                          Expanded(child: CustomTextField(hintText: 'Last Name',)),
                        ],
                      ),
                      CustomTextField(hintText: 'Your phone Number'),
                      CustomTextField(hintText: 'Your email',),
                      CustomTextField(hintText: 'Your password',),



                      // Text('Forgot Password?', textAlign: TextAlign.end),
                      SizedBox(height: 20),
                      CustomTextButton(
                        text: 'Continue',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'By signing up, you agree to snap Terms of Service and Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already had an account?'),
                          SizedBox(width: 3),
                          Text(
                            'Sign in',
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
