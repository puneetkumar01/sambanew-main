import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sambanew/theme/apptheme.dart';

import '../../../components/button.dart';
import '../../../service/event_repo.dart';
import '../../../util/config.dart';
import 'booking_failed.dart';

class LoadingPaymentpgae extends StatefulWidget {
  const LoadingPaymentpgae(
      {super.key,
      required this.sno,
      required this.tno,
      required this.netTotal, required this.bkno});
  final String sno;
  final String tno;
    final String bkno;
  final double netTotal;
  @override
  State<LoadingPaymentpgae> createState() => _nameState();
}

class _nameState extends State<LoadingPaymentpgae>
    with TickerProviderStateMixin {
  final int _counter = 0;
  late AnimationController _controller;
  int levelClock = 20;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        );

    _controller.forward();
    checkBooking();
  }

  int status = 0;
  checkBooking() {
     if (widget.netTotal > 0) {
    Timer(const Duration(seconds: 6), () {
     
        final service = EventService();

        service
            .apiConfirmPayment(widget.sno, widget.netTotal, widget.tno)
            .then((value) {
          if (value.statusCode == 200) {
            var data2 = jsonDecode(value.data);
            // response.add(LoginResponse.fromJson(value.data));
           // print("aa2a"+data2["data"][0]);
            if (data2["data"][0]["bankTransactionId"] != null) {
              status = 1;
              setState(() {});
              Fluttertoast.showToast(
                  msg: "Ticket Booked Successfully",
                  backgroundColor: Colors.green,
                  gravity: ToastGravity.TOP,
                  textColor: Colors.white);
            } else {
              Get.offAll(const BookingFailed());
            }
          } else {
            status = 2;
            Get.offAll(const BookingFailed());
            Fluttertoast.showToast(
                msg: "Something went wrong",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        });
    
    });
     }
     else {
        status = 1;
        setState(() {});
        Fluttertoast.showToast(
            msg: "Ticket Booked Successfully",
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
  }
// {"status":1,"message":"Booking detail","data":[{"customerId":99,"eventId":47,"ssTransactionId":"sid20240812180904769071","bankTransactionId":"1723486152019","netTotal":50.00,"paymentTag":1,"name":"abnika Garg","mobile":"788753004","emailId":"abnikagarg10@gmail.com","bookingNo":"BN240813244AI2K","bookingId":227,"errorCode":1,"errorDesc":"Booking detail"}]}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 0,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Please wait..',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Countdown(
                  animation: StepTween(
                    begin: levelClock, // THIS IS A USER ENTERED NUMBER
                    end: 0,
                  ).animate(_controller),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Please don\'t press back button we check your payment status..',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            )
          : Column(
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
                      color: Color.fromARGB(255, 30, 222, 17)),
                  child: Icon(
                    Icons.check,
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
                    'Ticket booked successfully',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12),
                //   child: Text(
                //     'Your ticket isn\'t book due to some reason please try again later',
                //     style: Theme.of(context).textTheme.bodyMedium,
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(28),
                  ),
                  child: Button(
                      tittle: "View Booking",
                      tap: () {
                     //   Get.offAllNamed("/",parameters: {'pageIndex': "2"});
                     Get.offAllNamed("/ticketDetails/${widget.bkno}", arguments: {
                      "data":"booking"
                     });
                      }),
                ),
              ],
            ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({super.key, required this.animation})
      : super(listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0');

    print('animation.value  ${animation.value} ');
    print('inMinutes ${clockTimer.inMinutes.toString()}');
    print('inSeconds ${clockTimer.inSeconds.toString()}');
    print(
        'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.primaryColor)),
      child: Center(
        child: Text(
          timerText,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 28),
        ),
      ),
    );
  }
}
