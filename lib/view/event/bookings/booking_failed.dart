import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sambanew/theme/apptheme.dart';

import '../../../components/button.dart';
import '../../../util/config.dart';

class BookingFailed extends StatefulWidget {
  const BookingFailed({super.key});

  @override
  State<BookingFailed> createState() => _nameState();
}

class _nameState extends State<BookingFailed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 0,
              width: double.infinity,
            ),
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 238, 56, 43)),
              child: Icon(
                Icons.close_outlined,
                color: AppTheme.whiteBackgroundColor,
                size: 32,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Booking failed',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'We\'re sorry, but your ticket booking was not successful. Please try again or contact our customer support for assistance.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(28),
              ),
              child: Button(
                  tittle: "Continue",
                  tap: () {
                    Get.offAllNamed("/");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
