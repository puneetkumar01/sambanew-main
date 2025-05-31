import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/vendorController.dart';

import '../../theme/apptheme.dart';

class VendorDetails extends StatelessWidget {
  const VendorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Vendorcontroller>(builder: (controller) {
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
          : Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (controller.vndorDetails.first.data![0].vendorInfo!
                            .vendorBannerImage ==
                        null)
                      AspectRatio(
                        aspectRatio: 2 / 1.2,
                        child: Image.asset(
                          "assets/images/event4.png",
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.dstATop,
                        ),
                      )
                    else
                      AspectRatio(
                        aspectRatio: 2 / 1.2,
                        child: Image.network(
                          "${controller.vndorDetails.first.data![0].vendorInfo!.vendorLogoPath}${controller.vndorDetails.first.data![0].vendorInfo!.vendorBannerImage}",
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.vndorDetails.first.data![0].vendorInfo!.vendorName}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 18),
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
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "${controller.vndorDetails.first.data![0].vendorInfo!.vendorLogoPath}${controller.vndorDetails.first.data![0].vendorInfo!.vendorLogoImage}",
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
                                    "${controller.vndorDetails.first.data![0].vendorInfo!.vendorcompany}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "${controller.vndorDetails.first.data![0].vendorInfo!.totalFollower} Followers",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (controller.vndorDetails.first.data![0].vendorInfo!
                                  .vendorShortDescr !=
                              null)
                            Text(
                              "About",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 18),
                            ),
                          if (controller.vndorDetails.first.data![0].vendorInfo!
                                  .vendorShortDescr !=
                              null)
                            const SizedBox(
                              height: 6,
                            ),
                          if (controller.vndorDetails.first.data![0].vendorInfo!
                                  .vendorShortDescr !=
                              null)
                            Text(
                                controller.vndorDetails.first.data![0].vendorInfo!.vendorShortDescr.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 13, height: 2)),
                          if (controller.vndorDetails.first.data![0].vendorInfo!
                                  .vendorLongDescr !=
                              null)
                            const SizedBox(
                              height: 12,
                            ),
                          if (controller.vndorDetails.first.data![0].vendorInfo!
                                  .vendorLongDescr !=
                              null)
                            Text(
                              "${controller.vndorDetails.first.data![0].vendorInfo!.vendorLongDescr}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 13, height: 2),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _tabBar(),
                  ],
                ),
              ),
            );
    });
  }

  Widget _tabBar() {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      alignment: Alignment.topLeft,
      child: TabBar(
        controller: Get.find<Vendorcontroller>().tabController,
        indicatorColor: AppTheme.primaryColor,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        onTap: (value) {
          //  controller.selectIndex(value, profileList[0].data!.uuid.toString());
        },
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        tabs: const <Widget>[
          Tab(
            text: "  Upcoming Events  ",
          ),
          // Tab(
          //   text: "About",
          // ),
          Tab(
            text: "Previous Events",
          ),
        ],
      ),
    );
  }
}
