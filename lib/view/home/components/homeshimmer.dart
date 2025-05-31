import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sambanew/theme/apptheme.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              // color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 2 : 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Shimmer.fromColors(
                              baseColor: const Color.fromRGBO(73, 72, 72, 0.1),
                              highlightColor:
                                  AppTheme.primaryColor.withOpacity(0.1),
                              enabled: true,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.whiteBackgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            const Color(0x8C333335).withOpacity(0.2),
                                        offset: const Offset(
                                          0.0,
                                          1.0,
                                        ),
                                        blurRadius: 4.0,
                                        spreadRadius: 3),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Shimmer.fromColors(
                            baseColor: const Color.fromRGBO(73, 72, 72, 0.1),
                            highlightColor:
                                AppTheme.primaryColor.withOpacity(0.1),
                            enabled: true,
                            child: Container(
                              height: 14,
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Shimmer.fromColors(
              baseColor: const Color.fromRGBO(73, 72, 72, 0.1),
              highlightColor: AppTheme.primaryColor.withOpacity(0.1),
              enabled: true,
              child: Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              // color: Colors.white,
              
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 2 : 15),
                      child: Container(
                        decoration: BoxDecoration(
                         // color: Get.theme.cardColor,
                          border: Border.all(
                              color: Get.theme.canvasColor, width: .3),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        width: 220,
                        child: Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: const Color.fromRGBO(73, 72, 72, 0.1),
                              highlightColor:
                                  AppTheme.primaryColor.withOpacity(0.1),
                              enabled: true,
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(22),
                                      topRight: Radius.circular(22)),
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor:
                                            const Color.fromRGBO(73, 72, 72, 0.1),
                                        highlightColor: AppTheme.primaryColor
                                            .withOpacity(0.1),
                                        enabled: true,
                                        child: Container(
                                          height: 10.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor:
                                            const Color.fromRGBO(73, 72, 72, 0.1),
                                        highlightColor: AppTheme.primaryColor
                                            .withOpacity(0.1),
                                        enabled: true,
                                        child: Container(
                                          height: 10.h,
                                          width: 160.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor:
                                            const Color.fromRGBO(73, 72, 72, 0.05),
                                        highlightColor: AppTheme.primaryColor
                                            .withOpacity(0.1),
                                        enabled: true,
                                        child: Container(
                                          height: 10.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor:
                                            const Color.fromRGBO(73, 72, 72, 0.1),
                                        highlightColor: AppTheme.primaryColor
                                            .withOpacity(0.1),
                                        enabled: true,
                                        child: Container(
                                          height: 10.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor:
                                            const Color.fromRGBO(73, 72, 72, 0.1),
                                        highlightColor: AppTheme.primaryColor
                                            .withOpacity(0.1),
                                        enabled: true,
                                        child: Container(
                                          height: 35,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // Row(
            //   children: [
            //     Shimmer.fromColors(
            //       baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //       highlightColor: AppTheme.primaryColor.withOpacity(0.1),
            //       enabled: true,
            //       child: Container(
            //         height: 50,
            //         width: 50,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(4),
            //           color: Colors.grey.shade100,
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(left: 10),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Shimmer.fromColors(
            //                   baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //                   highlightColor:
            //                       AppTheme.primaryColor.withOpacity(0.1),
            //                   enabled: true,
            //                   child: Container(
            //                     height: 10.h,
            //                     width: 100.w,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(4),
            //                       color: Colors.grey.shade100,
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 10.h,
            //                 ),
            //                 Shimmer.fromColors(
            //                   baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //                   highlightColor:
            //                       AppTheme.primaryColor.withOpacity(0.1),
            //                   enabled: true,
            //                   child: Container(
            //                     height: 10.h,
            //                     width: 80.w,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(4),
            //                       color: Colors.grey.shade100,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Row(
            //             children: [
            //               Shimmer.fromColors(
            //                 baseColor: Color.fromRGBO(255, 255, 255, 0.2),
            //                 highlightColor: Colors.grey.shade100,
            //                 enabled: true,
            //                 child: Container(
            //                   height: 28.h,
            //                   width: 72.w,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(6),
            //                     color: Colors.grey.shade100,
            //                   ),
            //                 ),
            //               ),
            //               Shimmer.fromColors(
            //                 baseColor: Colors.grey.shade300,
            //                 highlightColor: Colors.grey.shade100,
            //                 enabled: true,
            //                 child: GestureDetector(
            //                   child: Icon(
            //                     Icons.more_vert,
            //                     size: 26.sp,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Shimmer.fromColors(
            //   baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //   highlightColor: AppTheme.primaryColor.withOpacity(0.1),
            //   enabled: true,
            //   child: Container(
            //     height: 16.h,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(50),
            //       color: Colors.grey.shade100,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Shimmer.fromColors(
            //   baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //   highlightColor: AppTheme.primaryColor.withOpacity(0.1),
            //   enabled: true,
            //   child: Container(
            //     height: 16.h,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(50),
            //       color: Colors.grey.shade100,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Shimmer.fromColors(
            //   baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //   highlightColor: AppTheme.primaryColor.withOpacity(0.1),
            //   enabled: true,
            //   child: Container(
            //     height: 16.h,
            //     width: 100.w,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(50),
            //       color: Colors.grey.shade100,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Shimmer.fromColors(
            //   baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //   highlightColor: AppTheme.primaryColor.withOpacity(0.1),
            //   enabled: true,
            //   child: Container(
            //     height: 200.h,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.grey.shade100,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Shimmer.fromColors(
            //           baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //           highlightColor: AppTheme.primaryColor.withOpacity(0.1),
            //           enabled: true,
            //           child: Container(
            //             height: 20.h,
            //             width: 20.w,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(5),
            //               color: Colors.grey.shade100,
            //             ),
            //           ),
            //         ),
            //         Shimmer.fromColors(
            //           baseColor: Color.fromRGBO(73, 72, 72, 0.1),
            //           highlightColor: AppTheme.primaryColor.withOpacity(0.1),
            //           enabled: true,
            //           child: Container(
            //             height: 20.h,
            //             width: 20.w,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(5),
            //               color: Colors.grey.shade100,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Shimmer.fromColors(
            //       baseColor: Color.fromRGBO(255, 255, 255, 0.2),
            //       highlightColor: Color.fromRGBO(255, 255, 255, 0.2),
            //       enabled: true,
            //       child: Container(
            //         height: 20.h,
            //         width: 120.w,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(50),
            //           color: Colors.grey.shade100,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
