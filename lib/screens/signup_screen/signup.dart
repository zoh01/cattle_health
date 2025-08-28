import 'dart:ui';

import 'package:cattle_health/screens/signup_screen/widgets/signup_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(-5, .7),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF558B2F)),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(5, .7),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF558B2F)),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-5, -1),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFE64A19)),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(5, -1),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFE64A19)),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.only(
                        ),
                        child: Material(
                          elevation: 5,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 25),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Column(
                              children: [
                                SignUpTextForm(),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
