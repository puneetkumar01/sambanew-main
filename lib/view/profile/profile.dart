import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/view/profile/following_list.dart';
import 'package:sambanew/view/profile/privacy_policy.dart';
import 'package:sambanew/view/profile/purchase_policy.dart';

import '../../components/button.dart';
import '../../components/dialogs.dart';
import '../../controller/homeController.dart';
import '../../service/shared_pref.dart';
import '../../theme/apptheme.dart';
import '../../util/config.dart';
import 'saved_events.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  void dialog() {
    DialogHelper.showLoading();
    Future.delayed(const Duration(milliseconds: 400), () {
      PreferenceUtils().remove("token");
      PreferenceUtils().remove("customerId");
      PreferenceUtils().remove("email");
      PreferenceUtils().remove("name");

      Get.offAllNamed("/login");
    });

    //   PreferenceUtils().remove("Token");
    //    PreferenceUtils().remove("Token");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Get.theme.cardColor,
        appBar: AppBar(
            elevation: 0,
          //  backgroundColor: Get.theme.cardColor,
            title: Text(
              "profile".tr,
              style: Theme.of(context).textTheme.headlineMedium,
            )),
        body: !PreferenceUtils.isLoggedIn()
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/profile.jpeg'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Guest",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 24),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(28),
                      ),
                      child: Button(
                        tittle: "Continue to Sign In".tr,
                        tap: () {
                          Get.toNamed("/login");
                        },
                      ),
                    ),
                  ],
                ),
              )
            : !controller.isLoadedProfile
                ? Center(
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
                  )
                : SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/profile.jpeg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            PreferenceUtils.getString("name"),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 24),
                          ),
                          Text(
                            PreferenceUtils.getString("email"),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector( behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  controller.getLikedEvents();
                                  Get.to(const LikeEvents());
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "${controller.likeEventList.length}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Saved".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 16,
                                              color: AppTheme.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              // Column(
                              //   children: [
                              //     Text(
                              //       "0",
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .bodySmall!
                              //           .copyWith(fontSize: 16),
                              //     ),
                              //     SizedBox(
                              //       height: 10.h,
                              //     ),
                              //     Text(
                              //       "My Tickets",
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .bodySmall!
                              //           .copyWith(
                              //               fontSize: 16,
                              //               color: AppTheme.primaryColor),
                              //     ),
                              //   ],
                              // ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  controller.gettFollowers();
                                  Get.to(const FollowingList());
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "${controller.vndorFollwers.length}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Following".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 16,
                                              color: AppTheme.primaryColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Settings".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontSize: 22),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("Account Settings",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .displayLarge!),
                                //     Icon(
                                //       Icons.arrow_forward,
                                //       size: 20,
                                //       color: AppTheme.primaryColor,
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 16.h,
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const Privacypolicy());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("privacy_policy".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: AppTheme.primaryColor,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const Purchasepolicy());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("purchase_policy".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: AppTheme.primaryColor,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "Account".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontSize: 22),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      //  context: Get.context,//
                                      CupertinoAlertDialog(
                                        title:  Text('delete_account'.tr),
                                        insetAnimationCurve: Curves.linear,
                                        insetAnimationDuration:
                                            const Duration(milliseconds: 500),
                                        content: const Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            "Are you sure you want to close your account",
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
                                            child:  Text('Cancel'.tr),
                                          ),
                                          CupertinoDialogAction(
                                            /// This parameter indicates the action would perform
                                            /// a destructive action such as deletion, and turns
                                            /// the action's text color to red.
                                            isDestructiveAction: true,
                                            onPressed: () {
                                            controller.deleteAccount();
                                            },
                                            child:  Text('delete'.tr),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('delete_account'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: AppTheme.primaryColor,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       "Give your feedback",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .headlineSmall!
                                //           .copyWith(fontSize: 16),
                                //     ),
                                //     Icon(
                                //       Icons.arrow_forward,
                                //       size: 20,
                                //       color: AppTheme.primaryColor,
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 20.h,
                                // ),
                                // Text(
                                //   "About",
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .headlineLarge!
                                //       .copyWith(fontSize: 24),
                                // ),
                                // SizedBox(
                                //   height: 20.h,
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       "Privacy Policy",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .headlineSmall!
                                //           .copyWith(fontSize: 16),
                                //     ),
                                //     Icon(
                                //       Icons.arrow_forward,
                                //       size: 20,
                                //       color: AppTheme.primaryColor,
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 16.h,
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       "Copy events to your calendar",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .headlineSmall!
                                //           .copyWith(fontSize: 16),
                                //     ),
                                //     Icon(
                                //       Icons.arrow_forward,
                                //       size: 20,
                                //       color: AppTheme.primaryColor,
                                //     )
                                //   ],
                                // ),

                                InkWell(
                                  borderRadius: BorderRadius.circular(22),
                                  onTap: () {
                                    Get.dialog(
                                      //  context: Get.context,//
                                      CupertinoAlertDialog(
                                        title: Text("logout".tr,),
                                        insetAnimationCurve: Curves.linear,
                                        insetAnimationDuration:
                                            const Duration(milliseconds: 500),
                                        content: const Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            "Are you sure you want to logout",
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
                                            child:  Text('Cancel'.tr),
                                          ),
                                          CupertinoDialogAction(
                                            /// This parameter indicates the action would perform
                                            /// a destructive action such as deletion, and turns
                                            /// the action's text color to red.
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              dialog();
                                            },
                                            child:Text("logout".tr,),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Get.theme.scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(22)),
                                    child: Center(
                                        child: Text("logout".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                  fontSize: 16,
                                                    color: AppTheme
                                                        .primaryColor))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                        ],
                      ),
                    ),
                  ),
      );
    });
  }
}
