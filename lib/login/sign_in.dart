import 'package:delivery_app/constants/colors.dart';
import 'package:delivery_app/login/sign_up.dart';
import 'package:delivery_app/widgets/custom_text_button.dart';
import 'package:delivery_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
                      'Welcome',
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
                      CustomTextField(hintText: 'Your email',),

                      CustomTextField(hintText: 'Your password',),

                      Text('Forgot Password?', textAlign: TextAlign.end),
                      SizedBox(height: 20),
                      CustomTextButton(
                        text: 'Get Started',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Need an account?'),
                          SizedBox(width: 5),
                          Text(
                            'Sign up',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
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
