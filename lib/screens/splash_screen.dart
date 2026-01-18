import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cattle_health/screens/health_monitor/cattle_monitor_screen.dart';
import 'package:cattle_health/utils/constants/image_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/constants/sizes.dart';
import '../utils/constants/text_string.dart';
import 'dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool zoh = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7)).then((zoh) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => const CattleMonitorScreen()));
    });
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      zoh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(ZohSizes.defaultSpace),
          child: zoh
              ? Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.transparent,
            enabled: zoh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: const AssetImage(
                      ZohImages.splashImage,
                    ),
                    height: MediaQuery.of(context).size.height * .5),
                SizedBox(height: ZohSizes.spaceBtwSections,),
                SizedBox(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 20),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          ZohTextString.splashText2,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: const AssetImage(
                    ZohImages.splashImage,
                  ),
                  height: MediaQuery.of(context).size.height * .5),
              SizedBox(height: ZohSizes.spaceBtwSections,),
              SizedBox(
                child: DefaultTextStyle(
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 20),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        ZohTextString.splashText2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


