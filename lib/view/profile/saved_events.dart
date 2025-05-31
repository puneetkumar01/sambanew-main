import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sambanew/models/EventLikeModel.dart';

import '../../controller/homeController.dart';
import '../../service/date_converter.dart';
import '../../theme/apptheme.dart';

class LikeEvents extends StatelessWidget {
  const LikeEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Get.theme.cardColor,
          centerTitle: true,
          title: Text(
            "Saved Events",
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: GetBuilder<HomepageController>(builder: (controller) {
        return controller.isLoadedProfile
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      if (controller.likeEventList.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.likeEventList.length,
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 6),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    "/eventDetail/${controller.likeEventList[index].eventCode}");
                              },
                              child: Slidable(
                                // Specify a key if the Slidable is dismissible.
                                key: const ValueKey(0),

                                // The start action pane is the one at the left or the top side.

                                // The end action pane is the one at the right or the bottom side.
                                endActionPane:  ActionPane(
                                  extentRatio: 0.3,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                     
                                      onPressed: (context) {
                                         Get.dialog(
                                      //  context: Get.context,//
                                      CupertinoAlertDialog(
                                        title: const Text('Remove Event'),
                                        insetAnimationCurve: Curves.linear,
                                        insetAnimationDuration:
                                            const Duration(milliseconds: 500),
                                        content: const Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            "Are you sure you want to remove this from saved events",
                                          ),
                                        ),
                                        actions: <CupertinoDialogAction>[
                                          CupertinoDialogAction(
                                            /// This parameter indicates this action is the default,
                                            /// and turns the action's text to bold text.
                                            isDefaultAction: true,
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child:   Text('Cancel'.tr),
                                          ),
                                          CupertinoDialogAction(
                                            /// This parameter indicates the action would perform
                                            /// a destructive action such as deletion, and turns
                                            /// the action's text color to red.
                                            isDestructiveAction: true,
                                            onPressed: () {
                                           controller.likeEvent(controller.likeEventList[index].eventCode);  Get.back();
                                            },
                                            child: const Text('Remove'),
                                          ),
                                        ],
                                      ),
                                         );
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                    
                                    ),
                                  ],
                                ),
                                child: Eventcard(
                                  events: controller.likeEventList[index],
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Container(
                            child: Text("no_records_found".tr),
                          ),
                        )
                    ],
                  ),
                ),
              )
            : Container();
      }),
    );
  }
}

class Eventcard extends StatelessWidget {
  const Eventcard({
    super.key,
    required this.events,
  });
  final EventLikeModelData events;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x8C333335).withOpacity(0.1),
            offset: const Offset(-1, -1),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: (events.eventBannerImage1 != null)
                ? CachedNetworkImage(
                    imageUrl:
                        "${events.eventBannerImagePath.toString()}${events.eventBannerImage1.toString()}",
                    imageBuilder: (context, imageProvider) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          height: 100,
                          width: 110,
                          "${events.eventBannerImagePath.toString()}${events.eventBannerImage1.toString()}",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    fadeInDuration: const Duration(seconds: 1),
                    placeholderFadeInDuration: const Duration(seconds: 1),
                    fadeInCurve: Curves.linear,
                    fadeOutCurve: Curves.linear,
                    fadeOutDuration: const Duration(seconds: 1),

                    // progressIndicatorBuilder: (context, url, progress) {
                    //   return CircularProgressIndicator();
                    // },

                    placeholder: (
                      context,
                      url,
                    ) =>
                        Shimmer.fromColors(
                          baseColor: const Color.fromRGBO(63, 62, 62, 0.2),
                          highlightColor: Colors.black,
                          child: Container(
                              height: 100,
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black54,
                              )),
                        ))
                : Container(
                    height: 100,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/event4.png"))),
                  ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${DateConverter.formatDate(DateTime.parse(events.startDate.toString()))} at ${events.startTime.toString()}",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 10,
                    ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                events.eventName.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13,
                    ),
                maxLines: 2,
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/locationnew.svg",
                      height: 20,
                      color: AppTheme.primaryColor,
                      fit: BoxFit.scaleDown),
                  Text(' ${events.venue.toString()}',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/ticketer.svg",
                      color: AppTheme.veryLigthtext, fit: BoxFit.scaleDown),
                  Text(
                      " Tickets from ${events.icon.toString()}${events.ticketPriceOnward.toString()}",
                      style: Theme.of(context).textTheme.displayMedium!)
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
