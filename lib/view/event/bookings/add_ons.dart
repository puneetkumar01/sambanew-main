import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/eventController.dart';
import 'package:sambanew/models/AddOnModel.dart';
import 'package:sambanew/theme/apptheme.dart';
import 'package:sambanew/view/event/bookings/cart_bottomsheet.dart';

import '../../../components/button.dart';
import '../../../components/expandedText.dart';
import '../../../controller/ticketsController.dart';
import '../../../service/date_converter.dart';
import 'components/event_header.dart';

class AddOnsPage extends StatelessWidget {
  const AddOnsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Get.find<Eventcontroller>().eventData;
    var height = MediaQuery.of(context).viewPadding.top;
    return GetBuilder<TicketController>(builder: (controller) {
      return !controller.isAddOnLoaded
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
          :   Scaffold(backgroundColor: Get.theme.cardColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height + 20.h,
                    ),
                    HeaderEvent(
                      title: events.first.eventInfo!.eventName!,
                      date:
                          "${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.startDate.toString()))} at ${events.first.eventInfo!.startTime.toString()} - ${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.endDate.toString()))} at ${events.first.eventInfo!.endTime.toString()}",
                      ontap: () {
                        Get.back();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Looking for something extra?".tr,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppTheme.primaryColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {
                                Get.offNamed(
                                "/checkout/${Get.parameters["scdueleid"].toString()}",
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text("skip".tr, style: Theme.of(context).textTheme.bodyMedium,),
                              ),
                            ),
                          ),
                          //               InkWell(
                          //                 onTap: () {
                          //                   Get.offNamed(
                          //   "/checkout",
                          // );
                          //                 },
                          //                 child: Text(
                          //                   "Skip",
                          //                   style: Theme.of(context).textTheme.bodyMedium,
                          //                 ),
                          //               )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (controller.addonData.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        primary: false,
                        itemCount: controller.addonData.first.data!.length,
                        itemBuilder: (ctx, index) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: index == 0 ? 10.h : 8.h,
                              horizontal: 14),
                          child: AddOnCard(
                            data: controller.addonData.first.data![index],
                            addQuantity: () {
                              controller.onIncreaseAddOnQty(
                                  controller
                                      .addonData.first.data![index].eventId,
                                  controller
                                      .addonData.first.data![index].productId,
                                  controller.addonData.first.data![index].qty);
                            },
                            deleteQuantity: () {
                              controller.onDecreaseAddonQty(
                                  controller
                                      .addonData.first.data![index].eventId,
                                  controller
                                      .addonData.first.data![index].productId,
                                  controller.addonData.first.data![index].qty!);
                            },
                            icon: events.first.eventInfo!.icon!,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 90,
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
                child: GestureDetector(
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
                            height: 6,
                          ),
                          Icon(
                            Icons.keyboard_arrow_up_rounded,
                            size: 26,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub_Total".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    //  Icon(CupertinoIcons.arrow_down),
                                    Text(
                                      "${events.first.eventInfo!.icon!} ${(controller.totalAddOnCost + controller.totalTempCost)}",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                )
                              ]),
                          SizedBox(
                            height: 20.h,
                          ),
                          Button(
                            tittle: "Continue to Checkout".toUpperCase().tr,
                            tap: () {
                              if (controller.addonData.first.data!.any(
                                (element) => element.qty! > 0,
                              )) {
                                controller.addUpdatetProductCart(controller
                                    .cartItem.first.data![0].localSessionId);
                              } else {
                                Get.toNamed(
                                "/checkout/${Get.parameters["scdueleid"].toString()}",
                                );
                              }
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

class AddOnCard extends StatelessWidget {
  final Data data;
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  const AddOnCard({
    super.key,
    required this.data,
    required this.deleteQuantity,
    required this.addQuantity,
    required this.icon,
  });

  final String icon;

  Widget _incrementalWidget(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: deleteQuantity,
          child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: AppTheme.primaryColor,
              ),
              child: Icon(CupertinoIcons.minus,
                  size: 16, color: AppTheme.whiteBackgroundColor)),
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          "${data.qty}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          width: 8.w,
        ),
        InkWell(
          onTap: addQuantity,
          child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: AppTheme.primaryColor,
              ),
              child: Icon(CupertinoIcons.plus,
                  size: 16, color: AppTheme.whiteBackgroundColor)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle smallText =
        Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 13);
    TextStyle headingText =
        Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 13);
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
        border: Border.all(width: 01, color: AppTheme.border),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 8,
          ),
          if (data.imageName == null)
            Image.asset(
              "assets/images/food.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
          else
            Image.network(
              "${data.imagePath}${data.imageName}",
              fit: BoxFit.contain,
              height: 150,
              // height: 100,
              width: 100,
              colorBlendMode: BlendMode.darken,
            ),

          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "${data.productName}",
                      style: headingText,
                    ),
                  ),
                  const Divider(
                    thickness: 0.8,
                  ),
                  if (data.description.toString() != "")
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ExpandedText(
                        text: data.description.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(fontSize: 12),
                        length: 100,
                      ),
                    ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12),
                  //   child: Text(
                  //     "${data.description}",
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .labelSmall!
                  //         .copyWith(fontSize: 12),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$icon ${data.price.toString()}",
                          style: smallText,
                        ),
                        _incrementalWidget(context)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ]),
          ),

          //    _incrementalWidget(context)
        ],
      ),
    );
  }
}
