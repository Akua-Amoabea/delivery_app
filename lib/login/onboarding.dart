import 'package:delivery_app/login/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../widgets/custom_text_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Full screen background
            Image.asset(
              'assets/images/onboarding_background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            // Dark overlay
            Container(color: Colors.black.withValues(alpha: 0.3)),

            // Foreground content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('assets/images/logo_image.svg'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Request for Delivery in few clicks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'On-demand delivery whenever and wherever the need arises.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 80),
                          CustomTextButton(
                            text: 'Get Started',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Text(
                                'Have an account already? ',
                                style: TextStyle(color: Colors.white70),
                              ),
                              Text(
                                'SIGN IN',
                                style: TextStyle(
                                  color: background,
                                  decoration: TextDecoration.underline,
                                  decorationColor: background,
                                  fontWeight: FontWeight.bold,
                                ),
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
          ],
        ),
      ),
    );
  }
}
