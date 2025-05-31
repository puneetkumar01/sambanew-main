import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../controller/authController.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({
    super.key,
  });
  final otpFormKey = GlobalKey<FormState>();
  final _controller = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Form(
        key: otpFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'reset_password'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 24),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Please enter your email address to request a password reset"
                    .tr,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  preicon: SvgPicture.asset("assets/icons/mail.svg",
                      height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                  textEditingController: _controller.resetPasswordEmail,
                  validation: (value) {
                    RegExp emailValidatorRegExp = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                    if (value == null || value.isEmpty) {
                      return 'email_is_required'.tr;
                    } else if (!emailValidatorRegExp.hasMatch(value.trim())) {
                      return 'enter_valid_email'.tr;
                    }
                    return null;
                  },
                  hintText: "yourmail@gmail.com",
                  color: const Color(0xff585A60)),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Button(
                    tittle: "send".tr,
                    tap: () {
                      if (otpFormKey.currentState!.validate()) {
                        _controller.sendresetPassword();
                      }
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              // Center(
              //   child: Text(
              //     "Resend verification email",
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodySmall!
              //         .copyWith(fontSize: 15),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
