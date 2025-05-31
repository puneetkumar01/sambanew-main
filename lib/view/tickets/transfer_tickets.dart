import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/theme/apptheme.dart';


class TransferTickets extends StatelessWidget {
  const TransferTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ticketBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Text(
              "Transfer Tickets",
              style:
                  Get.theme.textTheme.headlineLarge!.copyWith(fontSize: 28),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Text(
              "Choose which tickets you would like to transfer!",
              style: Get.theme.textTheme.labelSmall!.copyWith(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          // SizedBox(
          //   height: 540.h,
          //   child: PageView.builder(
          //     itemCount: 3,
          //     onPageChanged: (value) {},
          //     physics: ClampingScrollPhysics(),
          //     itemBuilder: (context, index) {
          //       return Padding(
          //           padding:
          //               EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          //           child: buildTicketCard(index, context, () {}));
          //     },
          //   ),
          // ),
          Center(
            child: DotsIndicator(
              dotsCount: 3,
              position: 0,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeColor: AppTheme.extraLigthtext,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
