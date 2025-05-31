
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sambanew/models/BookingTicketsModel.dart';

import '../../../service/date_converter.dart';
import '../../../theme/apptheme.dart';

buildTicketCard(int index, context, VoidCallback callback, Data tickets) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Get.theme.cardColor,
      boxShadow: const [
        BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Colors.black26)
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0)),
              color: Color.fromRGBO(47, 47, 47, 1)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/newappicon.png",
                      height: 16,
                      width: 16,
                    ),
                    //  Text("  SAMBA ",
                    // style: GoogleFonts.inter(
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w700,
                    //   color: Color(0xFFFFFFFF),
                    // ))
                  ],
                ),
                Text("Ticket ${index + 1} ",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF),
                    ))
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "${tickets.ticketName}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: AppTheme.whiteBackgroundColor,
                height: 110,
                child: GestureDetector(
                    onTap: callback,
                    child: Image.memory(height: 100,
                      DateConverter.base64String(
                        tickets.newBookingNoQR!,
                      ),
                      gaplessPlayback: true,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${tickets.bookingNo}",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF7B7B7B),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time",
                      style: Get.theme.textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "${DateConverter.formatDate(DateTime.parse(tickets.startDate.toString()))} at ${tickets.startTime}",
                      style: Get.theme.textTheme.displaySmall!
                          .copyWith(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "location".tr,
                      style: Get.theme.textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "${tickets.venue}\n${tickets.venueAddress}",
                      style: Get.theme.textTheme.displaySmall!
                          .copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
              // if (Platform.isIOS) Spacer(),
              // if (Platform.isIOS)
              //   Image.asset(
              //     "assets/images/wallet.png",
              //     height: 45,
              //   ),
              // SizedBox(
              //   height: 12,
              // ),
            ]),
          ),
        )
      ],
    ),
  );
}
