import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sambanew/models/BookingHistoryModel.dart';
import 'package:sambanew/view/tickets/contact_organization.dart';
import 'package:sambanew/view/tickets/transfer_tickets.dart';

import '../../controller/homeController.dart';
import '../../service/date_converter.dart';
import '../../theme/apptheme.dart';
import '../../util/config.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key, required this.type});
  final int type;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(14),
            vertical: getProportionateScreenHeight(10)),
        child: GetBuilder<HomepageController>(
        //  init: HomepageController(),
          builder: (controller) {
          return controller.isLoadedBookings
              ? Column(
                  children: [
                    if (type == 1)
                      (controller.bookingUpHistory.isNotEmpty)
                          ? ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: controller.bookingUpHistory.length,
                              itemBuilder: (ctx, index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: TicketCard(
                                  bookings: controller.bookingUpHistory[index],
                                ),
                              ),
                            )
                          : Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/ticket2.svg",
                                    height: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text("You have no bookings"),
                                ],
                              ),
                            )
                    else
                      (controller.bookingPastHistory.isNotEmpty)
                          ? ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: controller.bookingPastHistory.length,
                              itemBuilder: (ctx, index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: TicketCard(
                                  bookings:
                                      controller.bookingPastHistory[index],
                                ),
                              ),
                            )
                          : Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/ticket2.svg",
                                    height: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text("You have no bookings"),
                                ],
                              ),
                            )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(50)),
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/preloader.gif',
                        ),
                      ),
                    ),
                  ),
                );
        }),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.bookings,
  });
  final BookingHistoryModelData bookings;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Get.theme.cardColor,
         boxShadow: [
          BoxShadow(
            color: const Color(0x8C333335).withOpacity(0.1),
            offset: const Offset(-1, -1),
            spreadRadius: 2,
            blurRadius: 12.0,
          ),
        ],
        border: Border.all(color: Get.theme.shadowColor, width: .2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bookings.eventBannerImage1 != null)
            AspectRatio(
              aspectRatio: 16 / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${bookings.eventBannerImagePath.toString()}${bookings.eventBannerImage1.toString()}",
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.dstATop,
                ),
              ),
            )
          else
            AspectRatio(
              aspectRatio: 16 / 4,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/ticket.PNG"))),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
            child: Text(
              "${bookings.eventName}",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ),
            child: Text(
              "${DateConverter.formatDate(DateTime.parse(bookings.startDate.toString()))} at ${bookings.startTime.toString()} - ${DateConverter.formatDate(DateTime.parse(bookings.utcEndDatetime.toString()))}",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/ticketDetails/${bookings.bookingNo}");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppTheme.primaryColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                      child: Text(
                        "View Ticket".tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: AppTheme.whiteBackgroundColor),
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     _displayDialogImage(context);
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12),
                //         border: Border.all(color: AppTheme.border)),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 16.w, vertical: 10.h),
                //       child: Text(
                //         "More",
                //         style: Theme.of(context)
                //             .textTheme
                //             .headlineMedium!
                //             .copyWith(fontSize: 15),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }

  _displayDialogImage(context) {
    return showDialog(
        context: context,
        barrierColor: Colors.black54,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(30)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 13.0, right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 0.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          'Options',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const TransferTickets());
                          },
                          child: Container(
                            width: 190.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppTheme.primaryColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Text(
                                "Transfer tickets",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const ContactOrganizer());
                          },
                          child: Container(
                            width: 190.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppTheme.ticketBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Text(
                                "Contact Organizer",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: AppTheme.darkTextColor, width: 1),
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child:
                                Icon(Icons.close, color: AppTheme.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
