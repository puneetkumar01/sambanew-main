import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/authController.dart';
import 'package:sambanew/theme/apptheme.dart';
import 'package:sambanew/util/app_images.dart';
import 'package:sambanew/view/auth/forgetpassword.dart';
import 'package:sambanew/view/auth/signup.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../service/shared_pref.dart';
import '../../util/config.dart';
import 'components/social_logins.dart';
import 'dart:io' show Platform;

class Login extends StatelessWidget {
  Login({super.key});
  final loginformKey = GlobalKey<FormState>();
  List socialLogis = [
    {
      "title": "${'continue_with'.tr} Google",
      "logo": "assets/images/google.png",
      "webview": "google",
    },
    {
      "title": "${'continue_with'.tr} Facebook",
      "logo": "assets/images/facebook.png",
      "webview": "facebook",
    },
    {
      "title": "${'continue_with'.tr} Apple",
      "logo": "assets/images/apple.png",
      "webview": "apple",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Get.theme.cardColor,
      body: GetBuilder<AuthController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: getProportionateScreenWidth(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (PreferenceUtils.getString("lastPage") ==
                              "eventdetails") {
                            PreferenceUtils().remove("lastPage");
                            Get.back(result: "1");
                          } else {
                            Get.offAllNamed("/");
                          }
                        },
                        child: Text(
                          "skip".tr,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8),
                ),
                Image.asset(
                  Images.logo,
                  height: 80,
                ),const SizedBox(
                  height:20,
                ),
               
                // SizedBox(
                //   height: getProportionateScreenHeight(2),
                // ),
                // Text(
                //   AppUrls.appName,
                //   style: Theme.of(context)
                //       .textTheme
                //       .headlineLarge!
                //       .copyWith(fontSize: 28),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: getProportionateScreenHeight(16)),
                  child: Form(
                    key: loginformKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         'sign_in'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(6),
                        ),
                        MyTextField(
                            preicon: SvgPicture.asset("assets/icons/mail.svg",
                                height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                            textEditingController: controller.email,
                            validation: (value) {
                              RegExp emailValidatorRegExp = RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                              if (value == null || value.isEmpty) {
                                return 'email_is_required'.tr;
                              } else if (!emailValidatorRegExp
                                  .hasMatch(value.trim())) {
                                return 'enter_valid_email'.tr;
                              }
                              return null;
                            },
                            hintText: "yourmail@gmail.com",
                            color: const Color(0xff585A60)),
                        MyTextField(
                            isSuffixIcon: true,
                            preicon: SvgPicture.asset("assets/icons/lock.svg",
                                height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                            textEditingController: controller.password,
                            obsecureText: !controller.passwordLoginVisibility,
                            ontapSuffix: () {
                              controller.showPassword();
                            },
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password_is_required'.tr;
                              }
                              return null;
                            },
                            hintText: 'your_password'.tr,
                            color: const Color(0xff585A60)),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: CupertinoSwitch(
                                      // This bool value toggles the switch.
                                      value: controller.isRemember,
                                     activeTrackColor: AppTheme.primaryColor,
                                      onChanged: (bool value) {
                                        controller.isRemeberChange();
                                        // This is called when the user toggles the switch.
                                      },
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: Text(' ${'rememberme'.tr}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall)),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.to(ForgetPassword());
                                },
                                child: Text('forgetpassword'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal:2,
                          ),
                          child: Button(
                              tittle: "sign_in".tr,
                              tap: () {
                                if (loginformKey.currentState!.validate()) {
                                  controller.submitLogin();
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "or".tr,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(16),
                ),
                ...List.generate(socialLogis.length, (index) {
                  if(!kIsWeb){

                  
                  if (!Platform.isIOS && index == 2) {
                    return Container();
                  }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SocialLogin(
                      assets: socialLogis[index]["logo"],
                      tittle: socialLogis[index]["title"],
                      webview: socialLogis[index]["webview"],
                    ),
                  );
                }),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                     'use_email_for'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(SignUp());
                        },
                        child: Text('signup'.tr,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.blue,
                                    )))
                  ],
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
