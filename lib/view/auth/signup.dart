import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../controller/authController.dart';
import '../../util/app_urls.dart';
import '../../util/config.dart';
import 'components/social_logins.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final signupformKey = GlobalKey<FormState>();
  launch() async {
    final Uri url2 = Uri.parse(AppUrls.baseUrl + "/Privacy");
    try {
      if (!await launchUrl(url2)) {
        throw Exception('Could not launch $url2');
      }
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

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
    return Scaffold( backgroundColor: Get.theme.cardColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (controller) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(12)),
                child: Form(
                  key: signupformKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'signup'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      MyTextField(
                          preicon: SvgPicture.asset("assets/icons/person.svg",
                              height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                          textEditingController: controller.name,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'full_name_is_required'.tr;
                            }
                            return null;
                          },
                          hintText: 'name'.tr,
                          color: const Color(0xff585A60)),
                      MyTextField(
                          preicon: SvgPicture.asset("assets/icons/mail.svg",
                              height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                          textEditingController: controller.signupEmail,
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
                          obsecureText: !controller.passwordLoginVisibility2,
                          ontapSuffix: () {
                            controller.showPassword2();
                          },
                          preicon: SvgPicture.asset("assets/icons/lock.svg",
                              height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                          textEditingController: controller.signupPassword,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password_is_required'.tr;
                            }
                            return null;
                          },
                          hintText: 'your_password'.tr,
                          color: const Color(0xff585A60)),
                      MyTextField(
                          isSuffixIcon: true,
                          obsecureText: !controller.passwordLoginVisibility3,
                          ontapSuffix: () {
                            controller.showPassword3();
                          },
                          preicon: SvgPicture.asset("assets/icons/lock.svg",
                              height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                          textEditingController: controller.signupConfirmPass,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'confirm_password_is_required'.tr;
                            } else if (value !=
                                controller.signupPassword.text) {
                              return 'the_passwords_do_not_match'.tr;
                            }
                            return null;
                          },
                          hintText: 'confirm_password'.tr,
                          color: const Color(0xff585A60)),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(2),
                        ),
                        child: Button(
                          tittle: 'signup'.tr,
                          tap: () {
                            if (signupformKey.currentState!.validate()) {
                              controller.signUpSubmit();
                            }
                          },
                        ),
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
                if (!Platform.isIOS && index == 2) {
                  return Container();
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
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "${'by_creating,youagreewithour'.tr}  ",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 14.sp, height: 1.4),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch();
                              //https://samba.events/Privacy
                            },
                          text: 'privacy_policy'.tr,
                          style: const TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        );
      })),
    );
  }
}
