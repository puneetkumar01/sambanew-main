import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sambanew/theme/apptheme.dart';
import 'package:sambanew/view/event/bookings/promocode.dart';

import '../../../components/button.dart';
import '../../../controller/eventController.dart';
import '../../../controller/ticketsController.dart';
import '../../../service/date_converter.dart';
import 'components/event_header.dart';
import 'payment_gateway.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    final events = Get.find<Eventcontroller>().eventData;
    String icon = events.first.eventInfo!.icon.toString();
    return GetBuilder<TicketController>(builder: (controller) {
      return !controller.loadedOrderSummary
          ? Scaffold(
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(50)
                  ),
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
            )
          : Scaffold(
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  SizedBox(
                    height: height + 20.h,
                  ),
                  HeaderEvent(
                    title: events.first.eventInfo!.eventName!,
                    ontap: () {
                      Get.back();
                    },
                    date:
                        "${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.startDate.toString()))} at ${events.first.eventInfo!.startTime.toString()} - ${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.endDate.toString()))} at ${events.first.eventInfo!.endTime.toString()}",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Almost there..!",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.border, width: 1),
                        borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          itemCount: controller.cartItem.first.data!.length,
                          primary: false,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          controller.cartItem.first.data![index]
                                                      .ticketName ==
                                                  ""
                                              ? "${controller.cartItem.first.data![index].qty} x ${controller.cartItem.first.data![index].productName}"
                                              : "${controller.cartItem.first.data![index].qty} x ${controller.cartItem.first.data![index].ticketName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 13))),
                                  Text(
                                      "$icon ${controller.cartItem.first.data![index].cost}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 14))
                                ],
                              ),
                            );
                          },
                        ),
                        // Text("1 ticket ",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .labelSmall!
                        //         .copyWith(fontSize: 14, height: 2)),
                        Divider(
                          color: AppTheme.border,
                          thickness: .9,
                          height: 20,
                        ),
                        // Text("Fri, 1 Dec, 2023 | 10:00 PM",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .labelSmall!
                        //         .copyWith(fontSize: 14)),
                        const SizedBox(
                          height: 2,
                        ),
                        Text("location".tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontSize: 14)),
                        const SizedBox(
                          height: 6,
                        ),
                        Text("${events.first.eventInfo!.venueAddress}",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 14)),
                        Divider(
                          color: AppTheme.border,
                          thickness: .9,
                          height: 20,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sub-total",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 14)),
                            Text("$icon ${controller.totalprice}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Convenience fee",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 14)),
                            Text("$icon ${controller.tax}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 14)),
                          ],
                        ),
                        if (controller.discount != '0')
                          const SizedBox(
                            height: 10,
                          ),
                        if (controller.discount != '0')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discount",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontSize: 14)),
                              Text("$icon ${controller.discount}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontSize: 14)),
                            ],
                          ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("total".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 14)),
                            Text("$icon ${controller.totalAmt}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 14)),
                          ],
                        ),
                        Divider(
                          color: AppTheme.border,
                          thickness: .9,
                          height: 20,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Contact Details",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 14)),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text("edit".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          fontSize: 14,
                                          color: AppTheme.primaryColor)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            "${controller.email.text}\n${controller.name.text} | ${controller.mobile.text}",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 14)),
                        const SizedBox(
                          height: 2,
                        ),
                        Divider(
                          color: AppTheme.border,
                          thickness: .9,
                          height: 20,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        if (controller.applyCoupon == "")
                          InkWell(
                            onTap: () {
                              Get.to(const PromoCodePage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/discount.svg",
                                  height: 14,
                                ),
                                Text("   Apply Promocodes   ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontSize: 14)),
                                SvgPicture.asset(
                                  "assets/icons/forward.svg",
                                  height: 14,
                                ),
                              ],
                            ),
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/discount.svg",
                                height: 14,
                              ),
                              Text("   ${controller.applyCoupon}   ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontSize: 14,
                                      )),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  controller.removeCoupon(
                                      events.first.eventInfo!.eventId);
                                },
                                child: const Icon(
                                  Icons.close_outlined,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       RichText(
                  //         textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  //         text: TextSpan(
                  //           text: 'Powered by ',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .labelSmall!
                  //               .copyWith(fontSize: 12),
                  //           children: <TextSpan>[
                  //             TextSpan(
                  //                 text: 'Ticketer',
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.w600,
                  //                     color: AppTheme.primaryColor)),
                  //           ],
                  //         ),
                  //       ),
                  //       Text(
                  //         "English (US)",
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .labelSmall!
                  //             .copyWith(fontSize: 12),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 16.w),
                  //   height: 60,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Color(0x8C333335).withOpacity(0.1),
                  //           offset: Offset(1, 1),
                  //           blurRadius: 4.0,
                  //           spreadRadius: 2),
                  //     ],
                  //     color: Colors.black,
                  //     borderRadius: BorderRadius.circular(15.r),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Buy with ",
                  //         style: GoogleFonts.inter(
                  //             fontSize: 18,
                  //             color: AppTheme.whiteBackgroundColor,
                  //             fontWeight: FontWeight.w700),
                  //       ),
                  //       SvgPicture.asset(
                  //         "assets/icons/apple.svg",
                  //         height: 22,
                  //       ),
                  //       Text(
                  //         " Pay",
                  //         style: GoogleFonts.inter(
                  //             fontSize: 18,
                  //             color: AppTheme.whiteBackgroundColor,
                  //             fontWeight: FontWeight.w700),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Button(
                        tittle: double.parse(controller.totalAmt.toString())>0?"pay another way".toUpperCase():"CONTINUE",
                        tap: () async {
                          await controller.getPaymentGateway(events.first.eventInfo!.eventId);
                          if (controller.paymentGatewayList.isNotEmpty) {
                            Get.to(const PaymentGateway(), fullscreenDialog: true);
                          } else {
                            Get.snackbar("Error", "No payment gateway found");
                          }

                        }),
                  ),
                ])));
    });
  }
}
