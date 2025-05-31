import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/components/dialogs.dart';
import 'package:sambanew/controller/eventController.dart';
import 'package:sambanew/controller/ticketsController.dart';
import 'package:sambanew/models/TicketerModel.dart';
import 'package:sambanew/service/shared_pref.dart';
import 'package:sambanew/theme/apptheme.dart';
import 'package:sambanew/view/event/bookings/cart_bottomsheet.dart';
import '../../../components/button.dart';
import '../../../components/expandedText.dart';
import '../../../components/input_field.dart';
import '../../../service/date_converter.dart';
import 'components/event_header.dart';

class SelectTicketPage extends StatelessWidget {
  const SelectTicketPage({super.key});

 // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    Future<bool> onwillpoo() async {
      //   Get.offAllNamed(Routes.HOME, parameters: {'pageIndex': "1"});
      if (Get.find<TicketController>().cartItem.isNotEmpty) {
        DialogHelper.cupertinoDialog(() {
          Get.find<TicketController>()
              .apiEmptyCart(PreferenceUtils.getString("localSession"));
          Get.back();
          Get.back();
        });
      } else {
        Get.back();
      }

      return false;
    }

    final events = Get.find<Eventcontroller>().eventData;
    return GetBuilder<TicketController>(builder: (controller) {
      return !controller.isLoaded
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
          : WillPopScope(
              onWillPop: onwillpoo,
              // canPop: false,
              // onPopInvoked: (didPop) async {
              //   if (didPop) {
              //     // If back navigation was allowed, do nothing.
              //     return;
              //   }
              //   final backNavigationAllowed = await onwillpoo();
              //   if (backNavigationAllowed) {
              //     // Manually navigate back
              //     ///   Navigator.of(context).pop();
              //   } else {
              //     // User is still on the same page, do whatever you want
              //   }
              // },
              child: Scaffold(backgroundColor: Get.theme.cardColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height + 20.h,
                      ),
                      HeaderEvent(
                        title: events.first.eventInfo!.eventName!,
                        ontap: () {
                          onwillpoo();
                        },
                        date:
                            "${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.startDate.toString()))} at ${events.first.eventInfo!.startTime.toString()} - ${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.endDate.toString()))} at ${events.first.eventInfo!.endTime.toString()}",
                      ),
                      //     width: double.infinity,
                      //     child: IntrinsicHeight(
                      //       child: Stack(
                      //         alignment: Alignment.topCenter,
                      //         children: [
                      //           Align(
                      //             child: Column(
                      //               children: [
                      //                 Text(
                      //                   events.first.eventInfo!.eventName!,
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .headlineLarge!
                      //                       .copyWith(fontSize: 20),
                      //                   textAlign: TextAlign.center,
                      //                 ),
                      //                 SizedBox(
                      //                   height: 5.h,
                      //                 ),
                      //                 Text(
                      //                   "${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.startDate.toString()))} at ${events.first.eventInfo!.startTime.toString()} - ${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.endDate.toString()))} at ${events.first.eventInfo!.endTime.toString()}",
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyMedium!
                      //                       .copyWith(fontSize: 10),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Positioned(
                      //               left: 16,
                      //               child: GestureDetector(
                      //                 onTap: () {
                      //                   Get.back();
                      //                 },
                      //                 child: Icon(
                      //                   Icons.arrow_back,
                      //                   color: AppTheme.darkTextColor,
                      //                 ),
                      //               )),
                      //         ],
                      //       ),
                      //     )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                  textEditingController:
                                      controller.accessTextBox,
                                  hintText: "Enter your access code here..".tr,
                                  color: const Color(0xff585A60)),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppTheme.primaryColor),
                                  borderRadius: BorderRadius.circular(12)),
                              child: InkWell(
                                onTap: () {
                                  if (controller.accessTextBox.text != "") {
                                    controller.applyAccessCode();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Text("Apply".tr),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        primary: false,
                        itemCount: controller.ticketData.length,
                        itemBuilder: (ctx, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TicketCard(
                            icon: events.first.eventInfo!.icon!,
                            ticket: controller.ticketData[index],
                            addQuantity: () {
                              if(  controller.ticketData[index].ticketStock! <= controller.ticketData[index].qty!){
                                DialogHelper.showErroDialog(description: "Only ${controller.ticketData[index].ticketStock} qty is left");
                                return;
                              }
                              controller.onIncreaseTicketQty(
                                  controller.ticketData[index].eventId,
                                  controller.ticketData[index].eventTicketId,
                                  controller.ticketData[index].qty);
                            },
                            qty: controller.ticketData[index].qty.toString(),
                            deleteQuantity: () {
                              controller.onDecreaseTicketQty(
                                  controller.ticketData[index].eventId,
                                  controller.ticketData[index].eventTicketId,
                                  controller.ticketData[index].qty!);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: controller.ticketData.every(
                  (element) => element.qty! < 1,
                )
                    ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      )
                    : GestureDetector(
                        onVerticalDragEnd: (details) {
                          double position = MediaQuery.of(context).size.height -
                              details.globalPosition.dy;
                          print('position dy = ${details.globalPosition.dx}');
                          ModelBottomSheet.showModal(context);
                        },
                        onPanUpdate: (details) {
                          if (details.delta.dx > 0) {
                            print("Dragging in +X direction");
                          } else {
                            print("Dragging in -X direction");
                          }

                          if (details.delta.dy > 0) {
                            print("Dragging in +Y direction");
                          } else {
                            print("Dragging in -Y direction");
                          }
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          decoration: BoxDecoration(
                              color:Get.theme.cardColor,
                              boxShadow: [
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
                                  height: 6,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 30,
                                  color: Get.theme.primaryColor,
                                ),

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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sub_Total",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14),
                                      ),
                                      Row(
                                        children: [
                                          //  Icon(CupertinoIcons.arrow_down),
                                          Text(
                                            "${events.first.eventInfo!.icon!} ${controller.totalTempCost}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      )
                                    ]),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Button(
                                  tittle: "Continue to add-ons".toUpperCase().tr,
                                  tap: () {
                                    if (controller.cartItem.isEmpty) {
                                      controller.startTimer();
                                      controller.addTicketCart();
                                    } else {
                                      controller.apiDeleteCart(controller
                                          .cartItem
                                          .first
                                          .data![0]
                                          .localSessionId);
                                    }

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
              ),
            );
    });
  }
}

class TicketCard extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  const TicketCard({
    super.key,
    required this.ticket,
    required this.deleteQuantity,
    required this.addQuantity,
    required this.icon,
    required this.qty,
  });
  final TicketerModelData ticket;
  final String icon;
  final String qty;
  Widget _incrementalWidget(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: deleteQuantity,
          child: Container(
              width: 24.h,
              height: 24.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: AppTheme.primaryColor,
              ),
              child: Icon(CupertinoIcons.minus,
                  size: 18, color: AppTheme.whiteBackgroundColor)),
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          qty,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          width: 8.w,
        ),
        InkWell(
          onTap: addQuantity,
          child: Container(
              width: 24.h,
              height: 24.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: AppTheme.primaryColor,
              ),
              child: Icon(CupertinoIcons.plus,
                  size: 18, color: AppTheme.whiteBackgroundColor)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle smallText = Theme.of(context).textTheme.labelMedium!;
    TextStyle headingText =
        Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14);
    return Container(
      
      decoration: BoxDecoration( color: Get.theme.cardColor,
          border: Border.all(width: 0.26),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.ticketName.toString(),
                      style: headingText,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "$icon ${ticket.ticketPrice.toString()}",
                        style: smallText,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    if (ticket.ticketDescription.toString() != "")
                      ExpandedText(
                        text: ticket.ticketDescription.toString(),
                        style: smallText,
                        length: 50,
                      ),
                  ]),
            ),
            SizedBox(
              width: 10.w,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: _incrementalWidget(context),
            )
          ],
        ),
      ),
    );
  }
}
