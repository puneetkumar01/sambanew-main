import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/ticketsController.dart';

import '../../../controller/homeController.dart';
import '../../../theme/apptheme.dart';

class ModelBottomSheet {
  static showModal(context) {
    return showModalBottomSheet(
        context: context,
        elevation: 2,
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return GetBuilder<TicketController>(builder: (controller) {
            return SingleChildScrollView(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Icon(Icons.keyboard_arrow_down,
                            size: 26, color: AppTheme.primaryColor),
                      ),
                      Text(
                        "tickets".tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (controller.ticketData.isNotEmpty)
                        ListView.builder(
                          itemCount: controller.ticketData.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            if (controller.ticketData[index].qty == 0) {
                              return Container();
                            }
                            return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${controller.ticketData[index].qty} x ${controller.ticketData[index].ticketName}"),
                                  SizedBox(
                                    width: 5.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "${(controller.ticketData[index].ticketPrice! * controller.ticketData[index].qty!)}",
                                      //   style: smallText,
                                    ),
                                  ),
                                ]);
                          },
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (controller.addonData.isNotEmpty)
                        if (controller.addonData.first.data!.any(
                          (element) => element.qty! > 0,
                        ))
                          Text(
                            "Add Ons",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 18),
                          ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (controller.addonData.isNotEmpty)
                        ListView.builder(
                          itemCount: controller.addonData.first.data!.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            if (controller.addonData.first.data![index].qty ==
                                0) {
                              return Container();
                            }
                            return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${controller.addonData.first.data![index].qty} x ${controller.addonData.first.data![index].productName}"),
                                  SizedBox(
                                    width: 5.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "${(controller.addonData.first.data![index].price! * controller.addonData.first.data![index].qty!)}",
                                      //   style: smallText,
                                    ),
                                  ),
                                ]);
                          },
                        ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     RichText(
                      //       textScaleFactor:
                      //           MediaQuery.of(context).textScaleFactor,
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
                      //                   color: AppTheme.primaryColor)),
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
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "SUBTOTAL",
                      //         style: Theme.of(context).textTheme.bodyLarge,
                      //       ),
                      //       Row(
                      //         children: [
                      //           //  Icon(CupertinoIcons.arrow_down),
                      //           Text(
                      //             "\$30.60",
                      //             style:
                      //                 Theme.of(context).textTheme.bodyLarge,
                      //           ),
                      //         ],
                      //       )
                      //     ]),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Button(
                      //   tittle: "Continue to add-ons".toUpperCase(),
                      //   tap: () {
                      //     if (_controller.cartItem.isEmpty) {
                      //       _controller.addTicketCart();
                      //     } else {
                      //       _controller.apiDeleteCart(_controller
                      //           .cartItem.first.data![0].localSessionId);
                      //     }
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                    ],
                  ),
                ),
              ),
            );
          });
        }).whenComplete(() {});
  }

  static List dates = ["Today", "Tomorrow", "This Week"];
  static void showFilterModal(context) {
     
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0.r),
            topRight: Radius.circular(10.0.r),
          ),
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: GetBuilder<HomepageController>(builder: (controller) {
                return SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(38.0.r),
                        topRight: Radius.circular(38.0.r),
                      ),
                      color: Get.theme.cardColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon(
                            //   Icons.remove,
                            //   color: Colors.grey[600],
                            //   size: 40,
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                width: 40,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Filter".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 22),
                            ),
                            if (controller.eventCategory.isNotEmpty)
                              SizedBox(
                                width: double.infinity,
                                // color: Colors.white,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        controller.eventCategory.length,
                                        (index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 10,
                                            left: index == 0 ? 6.w : 20.w),
                                        child: InkWell(
                                          onTap: () {
                                            controller.selectedFilter(controller
                                                .eventCategory[index]
                                                .eventTypeId);
                                            print(
                                                controller.selectedEventTypes);
                                          },
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: controller
                                                          .selectedEventTypes
                                                          .contains(controller
                                                              .eventCategory[
                                                                  index]
                                                              .eventTypeId)
                                                      ? AppTheme
                                                          .lightprimaryColor
                                                      : Get.theme.cardColor,
                                                  border: Border.all(
                                                    width: 0.3,
                                                    color: controller
                                                            .selectedEventTypes
                                                            .contains(controller
                                                                .eventCategory[
                                                                    index]
                                                                .eventTypeId)
                                                        ? AppTheme.primaryColor
                                                        : AppTheme
                                                            .whiteBackgroundColor,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color(0x8C333335)
                                                            .withOpacity(0.2),
                                                        offset: const Offset(
                                                          0.0,
                                                          1.0,
                                                        ),
                                                        blurRadius: 4.0,
                                                        spreadRadius: 3),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(9.0),
                                                  child: Image.network(
                                                      "${controller.eventCategory[index].imagePath.toString()}${controller.eventCategory[index].imageName.toString()}"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                controller.eventCategory[index]
                                                    .eventType
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(fontSize: 13),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Time & Date",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 16),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            // Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceAround,
                            //     children: List.generate(dates.length, (index) {
                            //       return Container(
                            //         padding: EdgeInsets.symmetric(
                            //             horizontal: 20.h, vertical: 10.w),
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             border:
                            //                 Border.all(color: AppTheme.border)),
                            //         child: Text(dates[index]),
                            //       );
                            //     })),
                            // SizedBox(
                            //   height: 20,
                            // ), 
                            Wrap(
                              spacing: 10.0,
                              children: [
                                FilterChip(
                                  label: const Text('Today'),
                                  backgroundColor: Get.theme.cardColor,
                                  selected:
                                      controller.filters.contains('today'),
                                  onSelected: (bool selected) {
                                    controller.toggleFilter('today');
                                  },
                                ),
                                FilterChip(
                                  label: const Text('Tomorrow'),
                                  backgroundColor: Get.theme.cardColor,
                                  labelPadding: EdgeInsets.zero,
                                  selected:
                                      controller.filters.contains('tomorrow'),
                                  onSelected: (bool selected) {
                                    controller.toggleFilter('tomorrow');
                                  },
                                ),
                                FilterChip(
                                  label: const Text('This Weekend'),
                                  backgroundColor: Get.theme.cardColor,
                                  selected:
                                      controller.filters.contains('weekend'),
                                  onSelected: (bool selected) {
                                    controller.toggleFilter('weekend');
                                  },
                                ),
                              ],
                            ), const SizedBox(
                              height: 20,
                            ), 
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 20.h, vertical: 10.w),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(color: AppTheme.border)),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       SvgPicture.asset("assets/icons/callender.svg"),
                            //       Text("  Choose from calender  "),
                            //       Icon(
                            //         Icons.arrow_forward_ios_rounded,
                            //         size: 16,
                            //         color: AppTheme.primaryColor,
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 20.h,
                            // ),
                            // Text(
                            //   "Location",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headlineLarge!
                            //       .copyWith(fontSize: 16),
                            // ),
                            // SizedBox(
                            //   height: 15.h,
                            // ),
                            // Container(
                            //   width: double.infinity,
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 12.h, vertical: 10.w),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(color: AppTheme.border)),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       Container(
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(16),
                            //             border: Border.all(
                            //                 width: 8,
                            //                 color: Color.fromRGBO(
                            //                     59, 211, 169, 0.3))),
                            //         alignment: Alignment.center,
                            //         height: 45,
                            //         width: 45,
                            //         child: SvgPicture.asset(
                            //           "assets/icons/location.svg",
                            //           color: AppTheme.primaryColor,
                            //         ),
                            //       ),
                            //       Expanded(child: Text("  New York, USA  ")),
                            //       Icon(
                            //         Icons.arrow_forward_ios_rounded,
                            //         size: 16,
                            //         color: AppTheme.primaryColor,
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 20.h,
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Select Price range",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontSize: 16),
                                ),
                                Text(
                                  "XOF ${controller.currentRangeValues.start.toInt()} - XOF ${controller.currentRangeValues.end.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                          fontSize: 16,
                                          color: AppTheme.whiteBackgroundColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 5.w),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: Utils.modelBuilder(
                            //       labels,
                            //       (index, label) {
                            //         final selectedColor = Colors.black;
                            //         final unselectedColor =
                            //             Colors.black.withOpacity(0.3);
                            //         final isSelected =
                            //             index >= valuesBottom.start &&
                            //                 index <= valuesBottom.end;
                            //         final color = isSelected
                            //             ? selectedColor
                            //             : unselectedColor;

                            //         return buildLabel(label: label, color: color);
                            //       },
                            //     ),
                            //   ),
                            // ),
                            SliderTheme(
                              data: const SliderThemeData(
                                trackHeight: 3,
                                rangeThumbShape: RoundRangeSliderThumbShape(
                                    enabledThumbRadius: 8),
                                overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 5),
                                activeTickMarkColor: Colors.transparent,
                                inactiveTickMarkColor: Colors.transparent,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RangeSlider(
                                      activeColor: AppTheme.primaryColor,
                                      inactiveColor: AppTheme.ticketBackground,
                                      values: controller.currentRangeValues,
                                      min: 0,
                                      max: 50000,
                                    //  divisions: 100,
                                      labels: RangeLabels(
                                        controller.currentRangeValues.start.round().toString(),
                                        controller.currentRangeValues.end.round().toString(),
                                      ),
                                      onChanged: (values) {
                                        controller.onchangeFilter(values);
                                        //setState(() => this.values = values),
                                      }),
                                ],
                              ),
                            ),
                           
                            SizedBox(
                              height: 30.h,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.cancelFilter();
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 38.w, vertical: 16.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: AppTheme.border)),
                                    child: Text(
                                      "RESET",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.applyFilter();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 66.w, vertical: 16.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppTheme.primaryColor),
                                    child: Text(
                                      "APPLY",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                              fontSize: 16,
                                              color: AppTheme
                                                  .whiteBackgroundColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ]),
                    ),
                  ),
                );
              }));
        });
  }
}
