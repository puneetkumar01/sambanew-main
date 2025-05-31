import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class HeaderEvent extends StatelessWidget {
  HeaderEvent({
    super.key,
    required this.title,
    required this.date,
    required this.ontap,
  });
  final String title;
  final String date;

  VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: IntrinsicHeight(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Get.width - 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        date,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
        //       Align(
        //   alignment: Alignment.bottomRight,
        //   child: Obx(() {
        //     final minutes =
        //         (Get.find<TicketController>().timeRemaining.value / 60).floor();
        //     final seconds = Get.find<TicketController>().timeRemaining.value % 60;
        //     return Container(
        //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        //         margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        //       decoration: BoxDecoration(
        //           color: Colors.red, borderRadius: BorderRadius.circular(4)),
        //       child: Text(
        //         '$minutes:${seconds.toString().padLeft(2, '0')}',
        //         style: TextStyle(
        //             fontSize: 11,
        //             fontWeight: FontWeight.w600,
        //             color: Colors.white),
        //       ),
        //     );
        //   }),
        // ),
              Positioned(
                  left: 10.w,
                  child: InkWell(
                    onTap: ontap,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      // color: AppTheme.darkTextColor,
                    ),
                  )),
            ],
          ),
        ));
  }
}
 // Align(
        //   alignment: Alignment.bottomRight,
        //   child: Obx(() {
        //     final minutes =
        //         (Get.find<TicketController>().timeRemaining.value / 60).floor();
        //     final seconds = Get.find<TicketController>().timeRemaining.value % 60;
        //     return Container(
        //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        //         margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        //       decoration: BoxDecoration(
        //           color: Colors.red, borderRadius: BorderRadius.circular(4)),
        //       child: Text(
        //         '$minutes:${seconds.toString().padLeft(2, '0')}',
        //         style: TextStyle(
        //             fontSize: 11,
        //             fontWeight: FontWeight.w600,
        //             color: Colors.white),
        //       ),
        //     );
        //   }),
        // )