import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/bookingHistoryController.dart';
import 'package:sambanew/service/date_converter.dart';
import 'package:sambanew/theme/apptheme.dart';
import '../../util/config.dart';
import 'compenents/ticket_card.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    final id = Get.parameters['id'];
    return GetBuilder<BookingHistoryController>(builder: (controller) {
      return !controller.isLoadedBookings
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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // AspectRatio(
                        //   aspectRatio: 2 / 1,
                        //   child: Image.asset(
                        //     "assets/images/event4.png",
                        //     fit: BoxFit.cover,
                        //     colorBlendMode: BlendMode.dstATop,
                        //   ),
                        // ),
                        if (controller.bookingHistory.first.data != null)
                          AspectRatio(
                            aspectRatio: 2 / 1,
                            child: Image.network(
                              controller.bookingHistory.first.data![0]
                                      .eventBannerImagePath! +
                                  controller.bookingHistory.first.data![0]
                                      .eventBannerImage1!,
                              fit: BoxFit.cover,
                              colorBlendMode: BlendMode.dstATop,
                            ),
                          )
                        else
                          AspectRatio(
                            aspectRatio: 2 / 1,
                            child: Image.asset(
                              "assets/images/event4.png",
                              fit: BoxFit.cover,
                              colorBlendMode: BlendMode.dstATop,
                            ),
                          ),
                        Positioned(
                            top: height + 5,
                            left: 10.w,
                            right: 10.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (Get.arguments != null) {
                                      Get.offAllNamed("/",
                                          parameters: {'pageIndex': "2"});
                                    } else {
                                      Get.back();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppTheme.whiteBackgroundColor,
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: AppTheme.darkTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   decoration: BoxDecoration(
                                //       color: AppTheme.whiteBackgroundColor,
                                //       shape: BoxShape.circle),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(4),
                                //     child: Icon(Icons.more_vert,color: AppTheme.darkTextColor,),
                                //   ),
                                // ),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (controller.bookingHistory.first.data != null)
                      SizedBox(
                        height: 550,
                        child: PageView.builder(
                          itemCount:
                              controller.bookingHistory.first.data!.length,
                          onPageChanged: (value) {
                            controller.onchange(value);
                          },
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: buildTicketCard(index, context, () {
                                  showModal2(
                                      context,
                                      controller.bookingHistory.first
                                          .data![index].newBookingNoQR,
                                      controller.bookingHistory.first
                                          .data![index].ticketName);
                                },
                                    controller
                                        .bookingHistory.first.data![index]));
                          },
                        ),
                      ),
                    if (controller.bookingHistory.first.data != null)
                      DotsIndicator(
                        dotsCount: controller.bookingHistory.first.data!.length,
                        position: controller.pagecontroller,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeColor: AppTheme.extraLigthtext,
                        ),
                      ),
                  ],
                ),
              ),
            );
    });
  }

  void showModal2(context, base64, ticketname) {
    showModalBottomSheet(
        context: context,
        backgroundColor: const Color.fromARGB(0, 112, 109, 109),
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (() {
              Navigator.of(context).pop();
            }),
            child: DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.2,
                maxChildSize: 0.7,
                builder: (_, controller) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.theme.cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0.r),
                          topRight: Radius.circular(50.0.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(children: [
                        // Icon(
                        //   Icons.remove,
                        //   color: Colors.grey[600],
                        //   size: 40,
                        // ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: getProportionateScreenWidth(40),
                          height: 4,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text("$ticketname",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontSize: 18)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            color: AppTheme.whiteBackgroundColor,
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.memory(
                                  DateConverter.base64String(base64),
                                  height: 200,fit: BoxFit.fill,
                                                      ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Scan your QR Ticket!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 18)),
                      ]),
                    ),
                  );
                }),
          );
        });
  }
}
