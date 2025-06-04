import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/eventController.dart';
import 'package:sambanew/controller/ticketsController.dart';
import 'package:sambanew/theme/apptheme.dart';
import '../../../components/button.dart';
import '../../../service/date_converter.dart';
import 'add_ons.dart';
import 'components/event_header.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway({super.key});

  @override
  State<PaymentGateway> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PaymentGateway> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;

    final events = Get.find<Eventcontroller>().eventData;
    String icon = events.first.eventInfo!.icon.toString();
    return GetBuilder<TicketController>(builder: (controller) {
      return !controller.loadedPaymentGateway
          ? Scaffold(
              body: Center(
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
            )
          : Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      height: 20,
                    ),
                    if (double.parse(controller.totalAmt.toString()) > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          "Choose Payment Method",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (double.parse(controller.totalAmt.toString()) > 0)
                      if (controller.paymentGatewayList.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppTheme.border, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              primary: false,
                              itemCount: controller
                                  .paymentGatewayList.first.data!.length,
                              itemBuilder: (ctx, index) => Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: index == 0
                                                ? BorderSide.none
                                                : const BorderSide(width: 0.3))),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        listTileTheme: const ListTileThemeData(
                                          horizontalTitleGap:
                                              4, //here adjust based on your need
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 4.0),
                                        child: RadioListTile(
                                          value: index,
                                          contentPadding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                          secondary: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Image.network(
                                              "${controller.paymentGatewayList.first.data![index].paymodes![0].imagePath}${controller.paymentGatewayList.first.data![index].paymodes![0].imageName}",
                                              height: 30,
                                            ),
                                          ),
                                          dense:
                                              true, // Set dense to true to reduce the space
                                          groupValue: 0,
                                          onChanged: (ind) {},
                                          title: Text(
                                              "${controller.paymentGatewayList.first.data![index].paymodes![0].paymode}"),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order Summary",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(fontSize: 16)),
                          const SizedBox(
                            height: 10,
                          ),
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
                                            controller
                                                        .cartItem
                                                        .first
                                                        .data![index]
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
                          const SizedBox(
                            height: 10,
                          ),
                             if(double.parse(controller.pgCharges)>0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("PG fee",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontSize: 14)),
                              Text("$icon ${controller.pgCharges}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontSize: 14)),
                            ],
                          ),
                             if(double.parse(controller.pgCharges)>0)
                          const SizedBox(
                            height: 10,
                          ),
                            if(double.parse(controller.tax1)>0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tax1",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontSize: 14)),
                              Text("$icon ${controller.tax1}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontSize: 14)),
                            ],
                          ),
                          if (double.parse(controller.tax2) > 0)
                            const SizedBox(
                              height: 10,
                            ),
                          if (double.parse(controller.tax2) > 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tax2",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontSize: 14)),
                                Text("$icon ${controller.tax2}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontSize: 14)),
                              ],
                            ),
                          // SizedBox(
                          //   height: 14,
                          // ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("Total",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .bodySmall!
                          //             .copyWith(fontSize: 14)),
                          //     Text("$icon ${controller.totalAmt}",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .bodySmall!
                          //             .copyWith(fontSize: 14)),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                decoration:
                    BoxDecoration(color: Get.theme.cardColor, boxShadow: [
                  BoxShadow(
                    color: const Color(0x8C333335).withOpacity(0.1),
                    offset: const Offset(-1, -1),
                    blurRadius: 12.0,
                  ),
                ]),
                child: Container(
                  decoration:
                      BoxDecoration(color: Get.theme.cardColor, boxShadow: [
                    BoxShadow(
                      color: const Color(0x8C333335).withOpacity(0.1),
                      offset: const Offset(-1, -1),
                      blurRadius: 12.0,
                    ),
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // Icon(
                        //   Icons.keyboard_arrow_up_rounded,
                        //   size: 26,
                        //   color: Get.theme.primaryColor,
                        // ),

                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     RichText(
                        //       textScaleFactor: MediaQuery.of(context)
                        //           .textScaleFactor,
                        //       text: TextSpan(
                        //         text: 'Powered by ',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .labelSmall!
                        //             .copyWith(fontSize: 12),
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: 'Ticketer',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600,
                        //                   color:
                        //                       AppTheme.primaryColor)),
                        //         ],
                        //       ),
                        //     ),
                        //     Text(
                        //       "English (US)",
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .labelSmall!
                        //           .copyWith(fontSize: 12),
                        //     )
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub Total",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 16),
                              ),
                              Row(
                                children: [
                                  //  Icon(CupertinoIcons.arrow_down),
                                  Text(
                                    "$icon ${controller.totalAmt}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              )
                            ]),
                        SizedBox(
                          height: 20.h,
                        ),
                        Button(
                          tittle:
                              double.parse(controller.totalAmt.toString()) > 0
                                  ? "Pay now".toUpperCase()
                                  : "Reserve Tickets".toUpperCase(),
                          tap: () {
                            controller.checkout(
                              events.first.eventInfo!.eventId,
                              events.first.eventInfo!.eventCode,
                              controller.totalAmt,
                            );

                            // Get.to(
                            //   AddOnsPage(),
                            //   transition: Transition.rightToLeft,
                            // );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
