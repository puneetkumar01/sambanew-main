import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/splashController.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     //  Color.fromRGBO(0, 255, 185, 0.4),
        //  Color.fromRGBO(12, 0, 0, 1),
        //     Color.fromRGBO(12, 0, 0, 1),
        //   ],
        // )),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              controller.image,
              height: 80,
            ),
            // SizedBox(
            //   height: getProportionateScreenHeight(2),
            // ),
            // Text(
            //   AppUrls.appName,
            //   style: Theme.of(context).textTheme.headlineLarge,
            // )
          ],
        ),
      ),
    );
  }
}
