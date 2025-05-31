import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../components/button.dart';
import '../../controller/authController.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.customerid});
final String customerid;
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Two-Factor Verification".tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 24),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "We’ve sent you an email with a 6-digit verification code. To continue, please enter the code below!".tr,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 15),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Pinput(
                  controller: _controller.pinController,
                  length: 6,
                  autofocus: true,
                  forceErrorState: true,
                  onCompleted: (pin) => print(pin),
                  defaultPinTheme: PinTheme(
                    width: 40.h,
                    height: 40.h,
                    textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: BoxDecoration(
                      color: const Color(0xff585A60).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  validator: (pin) {
                    if (pin!.length >= 6) return null;
                    return 'Enter Valid OTP'.tr;
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Button(
                    tittle: "continue".tr,
                    tap: () {
                      if (otpFormKey.currentState!.validate()) {
                         _controller.submitOtp(customerid);
                      }
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  _controller.resendOtp(customerid, true);
                },
                child: Center(
                  child: Text(
                    "Resend verification email".tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
