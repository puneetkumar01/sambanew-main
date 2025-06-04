
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sambanew/controller/eventController.dart';
import '../../service/date_converter.dart';
import '../../theme/apptheme.dart';
import '../../util/app_urls.dart';
import '../../util/config.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['id'];
    return GetBuilder<Eventcontroller>(builder: (controller) {
      return !controller.isLoaded
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
          : Scaffold( backgroundColor: Get.theme.cardColor,
              appBar: AppBar(
                  backgroundColor: Get.theme.cardColor,
                  elevation: 0,
                  centerTitle: false,
                  titleSpacing: 0,
                  actions: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Icon(
                    //     CupertinoIcons.heart_fill,
                    //     color: AppTheme.darkTextColor,
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(right: 2),
                      alignment: Alignment.center,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          controller.likeEvent(
                              id,
                              controller
                                  .eventData.first.eventInfo!.eventLikeTag);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 100),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: (controller.eventData.first.eventInfo!
                                        .eventLikeTag !=
                                    0)
                                ? SvgPicture.asset(
                                    "assets/icons/likecolor.svg",
                                    key: const ValueKey("value"),
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/like.svg",
                                    color: Get.theme.canvasColor,
                                    key: const ValueKey("value1"),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          controller.shareContent(
                              AppUrls.baseUrl + "/eventDetail/${controller.eventData.first.eventInfo!.eventCode}/${controller.eventData.first.eventInfo!.eventName!.replaceAll(" ", "-")}",
                              controller.eventData.first.eventInfo!
                                      .eventBannerImagePath! +
                                  controller.eventData.first.eventInfo!
                                      .eventBannerImage1!);
                          // Share.share(
                          //     "check out my this event: https://samba.events/eventDetail/${controller.eventData.first.eventInfo!.eventCode}/${controller.eventData.first.eventInfo!.eventName!.replaceAll(" ", "-")}");
                        },
                        icon: const Icon(
                          Icons.share,
                        ))
                  ],
                  title: Text(
                    controller.eventData.first.eventInfo!.eventName.toString(),
                  )),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x8C333335).withOpacity(0.1),
                        offset: const Offset(1, 1),
                        blurRadius: 4.0,
                        spreadRadius: 2),
                  ],
                  color: Get.theme.cardColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ticket2.svg",
                            color: Get.theme.primaryColor,
                            height: 26,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${controller.eventData.first.eventInfo!.icon.toString()} ${controller.eventData.first.eventInfo!.ticketPriceOnward.toString()}",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                "  ${'onwards'.tr}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller
                              .eventData.first.eventInfo!.isRecurringTag!) {
                            Get.toNamed(
                              "/selectTicket/${controller.eventData.first.eventInfo!.eventId}/${controller.eventScheduleData[0].data![controller.selectedIndex].timeData![controller.selectedTimeIndex].eventRecurScheduleId}",
                            );
                          } else {
                            Get.toNamed(
                              "/selectTicket/${controller.eventData.first.eventInfo!.eventId}/0",
                            );
                          }
                        },
                        child: Container(
                          height: 40.h,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x8C333335).withOpacity(0.1),
                                  offset: const Offset(1, 1),
                                  blurRadius: 4.0,
                                  spreadRadius: 2),
                            ],
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "GETTICKETS".tr,
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.whiteBackgroundColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                controller: controller.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.eventData.first.eventInfo!.eventBannerImagePath!="")
                    //  Stack(
                    //    children: [
                          AspectRatio(
                                        aspectRatio: 2 / 1,
                                        child: Image.network(
                                          controller
                                                  .eventData
                                                  .first
                                                  .eventInfo!.eventBannerImagePath!+
                                              controller
                                                  .eventData
                                                  .first
                                                  .eventInfo!
                                                  .eventBannerImage1!,
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.dstATop,
                                        ),
                                      )
                      //     CarouselSlider.builder(
                      //         itemCount: controller
                      //             .eventData.first.eventGallery!.length,
                      //         itemBuilder: (context, index, realIndex) {
                      //           return Stack(
                      //             children: <Widget>[
                      //               ShaderMask(
                      //                 shaderCallback: (rect) {
                      //                   return const LinearGradient(
                      //                     begin: Alignment.topCenter,
                      //                     end: Alignment.bottomCenter,
                      //                     colors: [
                      //                       Color.fromRGBO(0, 57, 149, 1),
                      //                       Color.fromRGBO(0, 41, 161, 1),
                      //                     ],
                      //                   ).createShader(Rect.fromLTRB(
                      //                       10, 0, rect.width, rect.height));
                      //                 },
                      //                 blendMode: BlendMode.dstOver,
                      //                 child: AspectRatio(
                      //                   aspectRatio: 2 / 1,
                      //                   child: Image.network(
                      //                     controller
                      //                             .eventData
                      //                             .first
                      //                             .eventGallery![index]
                      //                             .imagePath! +
                      //                         controller
                      //                             .eventData
                      //                             .first
                      //                             .eventGallery![index]
                      //                             .imageName!,
                      //                     fit: BoxFit.cover,
                      //                     colorBlendMode: BlendMode.dstATop,
                      //                   ),
                      //                 ),
                      //               ),
                      //               // Positioned(
                      //               //   bottom: 12.h,
                      //               //   left: 10.w,
                      //               //   right: 0.0,
                      //               //   child: Column(
                      //               //     crossAxisAlignment: CrossAxisAlignment.start,
                      //               //     children: [
                      //               //       Text('FRIDAY AUG 24, 9PM',
                      //               //           style: GoogleFonts.inter(
                      //               //             color: AppTheme.whiteBackgroundColor,
                      //               //             fontSize: 12,
                      //               //           )),
                      //               //       Text('Brightlight Music Festival',
                      //               //           style: GoogleFonts.inter(
                      //               //             color: AppTheme.whiteBackgroundColor,
                      //               //             fontSize: 22,
                      //               //           )),
                      //               //       Row(
                      //               //         children: [
                      //               //           SvgPicture.asset("assets/icons/location.svg",
                      //               //               fit: BoxFit.scaleDown),
                      //               //           Text(' Singapore Stadium',
                      //               //               style: GoogleFonts.inter(
                      //               //                 color: AppTheme.whiteBackgroundColor,
                      //               //                 fontSize: 12,
                      //               //               )),
                      //               //           SizedBox(
                      //               //             width: 10.w,
                      //               //           ),
                      //               //           SvgPicture.asset("assets/icons/ticketer.svg",
                      //               //               fit: BoxFit.scaleDown),
                      //               //           Text('€40 - €90',
                      //               //               style: GoogleFonts.inter(
                      //               //                 color: AppTheme.whiteBackgroundColor,
                      //               //                 fontSize: 12,
                      //               //               )),
                      //               //         ],
                      //               //       ),
                      //               //     ],
                      //               //   ),
                      //               // ),
                      //             ],
                      //           );
                      //         },
                      //         options: CarouselOptions(
                      //           //  height: getProportionateScreenHeight(300),
                      //           aspectRatio: 2 / 1,
                      //           viewportFraction: 1,
                      //           initialPage: 0,
                      //           onPageChanged: (index, reason) {
                      //             // setState(() {
                      //             controller.updateCuoisel(index);
                      //             // });
                      //           },
                      //           enableInfiniteScroll: true,
                      //           reverse: false,
                      //           autoPlay: true,
                      //           autoPlayInterval: Duration(seconds: 3),
                      //           autoPlayAnimationDuration:
                      //               Duration(milliseconds: 800),
                      //           autoPlayCurve: Curves.fastOutSlowIn,
                      //           enlargeCenterPage: true,
                      //           // onPageChanged: pageController,
                      //           scrollDirection: Axis.horizontal,
                      //         )),
                      //     Positioned.fill(
                      //       bottom: 5.h,
                      //       child: Align(
                      //         alignment: Alignment.bottomCenter,
                      //         child: Container(
                      //           child: DotsIndicator(
                      //             dotsCount: controller
                      //                 .eventData.first.eventGallery!.length,
                      //             position: controller.current,
                      //             decorator: DotsDecorator(
                      //               size: const Size.square(9.0),
                      //               activeColor: AppTheme.whiteBackgroundColor,
                      //               activeSize: const Size(18.0, 9.0),
                      //               activeShape: RoundedRectangleBorder(
                      //                   borderRadius:
                      //                       BorderRadius.circular(5.0)),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // )
                    else
                      AspectRatio(
                        aspectRatio: 2 / 1,
                        child: Image.asset(
                          "assets/images/event4.png",
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.dstATop,
                        ),
                      ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.eventData.first.eventInfo!.eventName.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 22),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: Get.theme.scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SvgPicture.asset(
                                      "assets/icons/callender.svg"),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${DateConverter.formatDate(DateTime.parse(controller.eventData.first.eventInfo!.startDate.toString()))} at ${controller.eventData.first.eventInfo!.startTime.toString()}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${DateConverter.formatDate(DateTime.parse(controller.eventData.first.eventInfo!.endDate.toString()))} at ${controller.eventData.first.eventInfo!.endTime.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(16),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: Get.theme.scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SvgPicture.asset(
                                      "assets/icons/locationnew.svg"),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.eventData.first.eventInfo!.venue.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    controller.eventData.first.eventInfo!.venueAddress.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),

                          if (controller
                              .eventData.first.eventInfo!.isRecurringTag!)
                            Text(
                              "Select date and time".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 18),
                            ),
                          if (controller
                              .eventData.first.eventInfo!.isRecurringTag!)
                            const SizedBox(
                              height: 16,
                            ),
                          if (controller.eventScheduleData.isNotEmpty)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  controller
                                      .eventScheduleData.first.data!.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectIndex(
                                            index,
                                            controller
                                                .eventScheduleData
                                                .first
                                                .data![controller.selectedIndex]
                                                .timeData!
                                                .first
                                                .eventRecurScheduleId);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5,
                                                color: controller
                                                            .selectedIndex ==
                                                        index
                                                    ? AppTheme.lightprimaryColor
                                                    : AppTheme.homePagecolor3),
                                            //  boxShadow: [BoxShadow(offset: Offset(1, 1))],
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: REdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: controller
                                                              .selectedIndex ==
                                                          index
                                                      ? AppTheme
                                                          .lightprimaryColor
                                                      : const Color.fromRGBO(
                                                          205, 205, 205, 100),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                  DateFormat('dd').format(DateFormat('dd-MMM-yyyy').parse(controller.eventScheduleData.first.data![index].dateData!.eventDayStartDate!)),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge!
                                                      .copyWith(
                                                          fontSize: 14,
                                                          color: AppTheme
                                                              .blueColor)),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                                DateFormat('MMM').format(DateFormat('dd-MMM-yyyy').parse(controller.eventScheduleData.first.data![index].dateData!.eventDayStartDate!)),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: 14,
                                                    )),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          if (controller.eventScheduleData.isNotEmpty)
                            const SizedBox(
                              height: 20,
                            ),
                          if (controller.eventScheduleData.isNotEmpty)
                            Container(
                              height: 36,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: AppTheme.primaryColor),
                                  //  boxShadow: [BoxShadow(offset: Offset(1, 1))],
                                  borderRadius: BorderRadius.circular(50)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  showModal2(Get.context);
                                },
                                child: Center(
                                    child: Text(
                                  "${controller.eventScheduleData.first.data![controller.selectedIndex].timeData![controller.selectedTimeIndex].eventStartTime} - ${controller.eventScheduleData.first.data![controller.selectedIndex].timeData![controller.selectedTimeIndex].eventEndTime}",
                                  style: const TextStyle(
                                      
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ),
                          if (controller.eventScheduleData.isNotEmpty)
                            const SizedBox(
                              height: 20,
                            ),
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Get.toNamed("/vendorDeatils", arguments: {
                                'vendorcode': controller
                                    .eventData.first.eventInfo!.vendorCode
                                    .toString()
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "${controller.eventData.first.eventInfo!.vendorLogoPath.toString()}${controller.eventData.first.eventInfo!.vendorLogoImage.toString()}",
                                          )),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.eventData.first.eventInfo!.vendorName.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Organizer",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(fontSize: 12),
                                    )
                                  ],
                                )),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.bounceInOut,
                                  height: 36,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: controller.eventData.first
                                                  .eventInfo!.vendorfollowTag ==
                                              0
                                          ? Colors.transparent
                                          : AppTheme.primaryColor,
                                      border: Border.all(
                                          width: 0.5,
                                          color: controller
                                                      .eventData
                                                      .first
                                                      .eventInfo!
                                                      .vendorfollowTag ==
                                                  0
                                              ? Get.theme.canvasColor
                                              : AppTheme.primaryColor),
                                      //  boxShadow: [BoxShadow(offset: Offset(1, 1))],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      controller.followVendor(
                                          controller.eventData.first.eventInfo!
                                              .vendorId,
                                          controller.eventData.first.eventInfo!
                                              .vendorfollowTag);
                                    },
                                    child: Center(
                                        child: Text(
                                      controller.eventData.first.eventInfo!
                                                  .vendorfollowTag ==
                                              0
                                          ? "+ ${'Follow'.tr}"
                                          : "Following".tr,
                                      style: TextStyle(
                                          color: controller
                                                      .eventData
                                                      .first
                                                      .eventInfo!
                                                      .vendorfollowTag ==
                                                  0
                                              ? Colors.black
                                              : AppTheme.whiteBackgroundColor,
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (controller
                                  .eventData.first.eventInfo!.eventSummary !=
                              null)
                            Text(
                              "About_Event".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 18),
                            ),
                          if (controller
                                  .eventData.first.eventInfo!.eventSummary !=
                              null)
                            const SizedBox(
                              height: 6,
                            ),
                          if (controller
                                  .eventData.first.eventInfo!.eventSummary !=
                              null)
                            Text(
                                controller.eventData.first.eventInfo!.eventSummary.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 13, height: 2)),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          if (controller.eventData.first.eventInfo!
                                  .detailedDescription !=
                              null)
                            Text(
                              "Details".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 18),
                            ),
                          if (controller.eventData.first.eventInfo!
                                  .detailedDescription !=
                              null)
                            SizedBox(
                              height: getProportionateScreenHeight(6),
                            ),
                          // Text(
                          //     "${controller.eventData.first.eventInfo!.detailedDescription.toString()}",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyMedium!
                          //         .copyWith(fontSize: 13, height: 2)),

                          if (controller.eventData.first.eventInfo!
                                  .detailedDescription !=
                              null)
                            HtmlWidget(
                                controller.eventData.first.eventInfo!.detailedDescription.toString(),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 13, height: 2)),

                          const SizedBox(
                            height: 20,
                          ),
                          if (controller
                                  .eventData.first.eventInfo!.termsConditions !=
                              null)
                            GestureDetector(
                              onTap: () {
                                // Get.delete<Eventcontroller>();
                                //  controller.getEvents("ec9tT7D7");
                                //   Get.toNamed("/eventDetail/ec9tT7D7",preventDuplicates: false ,);
                                controller.updateSHow();
                                //brand
                                //approval sales invoive and order
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                //margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(232, 232, 232, 0.8),
                                    ),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Terms & Conditions".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 14),
                                    ),
                                    Icon(
                                        controller.isShow
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                        size: 16,
                                        color: AppTheme.primaryColor)
                                  ],
                                ),
                              ),
                            ),

                          // LayoutBuilder(builder: (context, constraints) {
                          //   return AnimatedContainer(
                          //     duration: Duration(seconds: 1),
                          //     width: controller.isShow
                          //         ? constraints.maxWidth
                          //         : 100, // Adjust the width as needed
                          //     height: controller.isShow
                          //         ? constraints.maxHeight
                          //         : 100, // Adjust the height as needed
                          //     curve: Curves.easeInOut,
                          //     child: Center(
                          //             child: Text(
                          //               controller.isShow ? 'Expanded' : 'Collapsed',
                          //               style: TextStyle(
                          //                   color: Colors.white, fontSize: 20),
                          //             ),

                          //     ),
                          //   );
                          // }),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            height: controller.isShow ? null : 0,
                            // switchInCurve: Curves.linear,
                            // transitionBuilder: (child, animation) {
                            //   return SizeTransition(
                            //     axisAlignment: 1,
                            //     sizeFactor: animation,
                            //     child: child,
                            //   );
                            // },
                            child: controller.isShow
                                ? SizedBox(
                                    height: controller.isShow ? null : 0.0,
                                    child: HtmlWidget(
                                        controller.eventData.first.eventInfo!.termsConditions.toString(),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 13, height: 2)),
                                  )
                                : null,
                          ),
                          // AnimatedSize(
                          //   curve: Curves.linear,
                          // duration: Duration(seconds: 1),
                          //   child: controller.isShow
                          //       ? Container(
                          //          height: controller.isShow? null : 0.0,
                          //         child: HtmlWidget(
                          //             """${controller.eventData.first.eventInfo!.termsConditions.toString()}""",
                          //             textStyle: Theme.of(context)
                          //                 .textTheme
                          //                 .bodyMedium!
                          //                 .copyWith(fontSize: 13, height: 2)),
                          //       )
                          //       : Container(),
                          // ),

                          SizedBox(
                            height: getProportionateScreenHeight(100),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
    });
  }

  void showModal2(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: const Color.fromARGB(0, 144, 143, 143),
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (() {
              Navigator.of(context).pop();
            }),
            child: GetBuilder<Eventcontroller>(builder: (getxcontroller) {
              return DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  minChildSize: 0.2,
                  maxChildSize: 0.4,
                  builder: (_, controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Get.theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0.r),
                          topRight: Radius.circular(50.0.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: getProportionateScreenWidth(40),
                          height: 4.h,
                          decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Select time",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: getxcontroller
                                .eventScheduleData
                                .first
                                .data![getxcontroller.selectedIndex]
                                .timeData!
                                .length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getxcontroller.eventScheduleData.first.data![getxcontroller.selectedIndex].timeData![index].eventStartTime} - ${getxcontroller.eventScheduleData.first.data![getxcontroller.selectedIndex].timeData![index].eventEndTime}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 15.sp),
                                        ),
                                        if (index ==
                                            getxcontroller.selectedTimeIndex)
                                          const Icon(
                                              CupertinoIcons
                                                  .checkmark_circle_fill,
                                              size: 20,
                                              color: Colors.blue)
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //       shape: BoxShape.circle,
                                        //       border: Border.all(
                                        //         color: Theme.of(context)
                                        //             .canvasColor,
                                        //       )),
                                        //       alignment: Alignment.center,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(2),
                                        //     child: Icon(Icons.circle,
                                        //         size: 10.sp,
                                        //         color: Colors.blue),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    getxcontroller.selectEventSchduele(
                                        index,
                                        getxcontroller
                                            .eventScheduleData
                                            .first
                                            .data![getxcontroller.selectedIndex]
                                            .timeData![index]
                                            .eventRecurScheduleId);
                                    // Get.find<AccountSetUpController>()
                                    //     .setAccountValue(items[index]);
                                    //    _controller.accountType.value =  TextEditingController(text: _items[index]);

                                    //  update(items[index]);
                                    Get.back();
                                  });
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                      ]),
                    );
                  });
            }),
          );
        });
  }
}

//bills
//legder
//order
//