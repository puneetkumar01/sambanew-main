import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/input_field.dart';
import '../../theme/apptheme.dart';

class ContactOrganizer extends StatelessWidget {
  const ContactOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ticketBackground,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      width: 60.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "General Admission",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Tuesday, 10:00PM - Wednesday 03:00AM",
                      style: Get.theme.textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Who is this ticket for?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 14),
                          ),
                          MyTextField(
                              preicon: SvgPicture.asset("assets/icons/person.svg",
                                  height: 5.h,
                                  width: 5.w,
                                  fit: BoxFit.scaleDown),
                              //textEditingController: _controller.emailController,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Full name is required";
                                }
                                return null;
                              },
                              hintText: "Full name",
                              color: const Color(0xff585A60)),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "What’s their email address?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 14),
                          ),
                          MyTextField(
                              preicon: SvgPicture.asset("assets/icons/mail.svg",
                                  height: 5.h,
                                  width: 5.w,
                                  fit: BoxFit.scaleDown),
                              //textEditingController: _controller.emailController,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                return null;
                              },
                              hintText: "abc@gmail.com",
                              color: const Color(0xff585A60)),
                          SizedBox(
                            height: 60.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/selectTicket");
                            },
                            child: Container(
                              height: 50.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0x8C333335).withOpacity(0.1),
                                      offset: const Offset(1, 1),
                                      blurRadius: 4.0,
                                      spreadRadius: 2),
                                ],
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                "Transfer tickets",
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: AppTheme.whiteBackgroundColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
