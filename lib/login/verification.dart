import 'package:delivery_app/constants/colors.dart';
import 'package:delivery_app/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/custom_text_button.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

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
                      "Enter the 4-digit code",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Please input your verification code sent to your number 23480*******90',
                      style: TextStyle(fontSize: 12),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Change number?',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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
                      OtpTextField(
                        numberOfFields: 5,

                        // borderColor: Color(0xFF512DA8),
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Verification Code"),
                                content: Text(
                                  'Code entered is $verificationCode',
                                ),
                              );
                            },
                          );
                        }, // end onSubmit
                      ),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          Text(
                            "Didn't get any code yet?",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Resend code',
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // Text('Forgot Password?', textAlign: TextAlign.end),
                      SizedBox(height: 60),
                      CustomTextButton(
                        text: 'Verify',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
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
