import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/homeController.dart';
import '../../models/EventModel.dart';
import '../../service/date_converter.dart';
import '../../theme/apptheme.dart';
import '../../util/config.dart';
import 'bookings/cart_bottomsheet.dart';

class AllEvents extends StatelessWidget {
  const AllEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: Text(
            "events".tr,
            
            style: Theme.of(context).textTheme.headlineMedium,
          ),
         
          ),
      body: GetBuilder<HomepageController>(builder: (controller) {
        return controller.isLoaded
            ? GestureDetector(
                onTap: () {
                  controller.focus.unfocus();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(14),
                        vertical: getProportionateScreenHeight(12)),
                    child: Column(
                      children: [
                          const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          //cursorColor: AppTheme.blueColor,
                          style: const TextStyle(fontSize: 14),
                          focusNode: controller.focus,
                          onChanged: (value) {
                            controller.searchList(value);
                          },
                          decoration: InputDecoration(
                              fillColor: AppTheme.homePagecolor2,
                              filled: true,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                 ,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppTheme.primaryColor,
                              ),
                              
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                  8, 8, 8, 8),
                              hintText: "Search for anything..".tr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: AppTheme.homePagecolor1,
                                    width: 0.6,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: AppTheme.homePagecolor1,
                                    width: 0.6,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: AppTheme.homePagecolor1,
                                     width: 0.6,
                                  )),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    right: 12, top: 6, bottom: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.focus.unfocus();
                                    Get.put<HomepageController>(
                                        HomepageController());
                                    ModelBottomSheet.showFilterModal(context);
                                  },
                                  child: Container(
                                    width: 86,
                                    decoration: BoxDecoration(
                                        color: controller.filterApplied
                                            ? AppTheme.primaryColor
                                            : AppTheme.blueColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  AppTheme.whiteBackgroundColor,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Icon(
                                              Icons.filter_list_sharp,
                                              size: 18.h,
                                              color: AppTheme.blueColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "   ${'Filters'.tr}",
                                          style: GoogleFonts.inter(
                                              fontSize: 11,
                                              color:
                                                  AppTheme.whiteBackgroundColor,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (controller.isLoadedAllEvents)
                          if (controller.eventData.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: controller.eventData.length,
                              itemBuilder: (ctx, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        "/eventDetail/${controller.eventData[index].eventInfo!.eventCode}");
                                  },
                                  child: Eventcard(
                                    events: controller.eventData[index],
                                  ),
                                ),
                              ),
                            )
                          else
                            Container(
                              child: Text("no_records_found".tr),
                            )
                        else
                          const Padding(
                              padding: EdgeInsets.all(90),
                              child: CircularProgressIndicator())
                      ],
                    ),
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
  final Data events;
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
            child: (events.eventInfo!.eventBannerImage1 != null)
                ? CachedNetworkImage(
                    imageUrl:
                        "${events.eventInfo!.eventBannerImagePath.toString()}${events.eventInfo!.eventBannerImage1.toString()}",
                    imageBuilder: (context, imageProvider) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          height: 100,
                          width: 110,
                          "${events.eventInfo!.eventBannerImagePath.toString()}${events.eventInfo!.eventBannerImage1.toString()}",
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
                "${DateConverter.formatDate(DateTime.parse(events.eventInfo!.startDate.toString()))} at ${events.eventInfo!.startTime.toString()}",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 10,
                    ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                events.eventInfo!.eventName.toString(),
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
                  Flexible(
                    child: Text(' ${events.eventInfo!.venue.toString()}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w400,
                        )),
                  )
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
                      " Tickets from ${events.eventInfo!.icon.toString()}${events.eventInfo!.ticketPriceOnward.toString()}",
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
