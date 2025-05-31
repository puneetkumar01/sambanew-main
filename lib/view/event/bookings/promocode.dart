import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/eventController.dart';
import 'package:sambanew/controller/ticketsController.dart';
import 'package:sambanew/models/PromoCode.dart';
import 'package:sambanew/theme/apptheme.dart';
import '../../../components/input_field.dart';
import '../../../service/date_converter.dart';
import 'components/event_header.dart';

class PromoCodePage extends StatefulWidget {
  const PromoCodePage({super.key});

  @override
  State<PromoCodePage> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Get.find<TicketController>().getPromo(
        Get.find<Eventcontroller>().eventData.first.eventInfo!.eventId);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;

    final events = Get.find<Eventcontroller>().eventData;
    return GetBuilder<TicketController>(builder: (controller) {
      return !controller.isLoadedPromos
          ? Scaffold(
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(50)
                  ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height + 20.h,
                    ),
                    HeaderEvent(
                      title: events.first.eventInfo!.eventName!,
                      ontap: () {
                        Get.back();
                      },
                      date:
                          "${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.startDate.toString()))} at ${events.first.eventInfo!.startTime.toString()} - ${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.endDate.toString()))} at ${events.first.eventInfo!.endTime.toString()}",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Got a promocode?",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              textEditingController: controller.promoController,
                                hintText: "Enter your promocode here..",
                                color: const Color(0xff585A60)),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppTheme.primaryColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {
                                controller.applied(controller.promoController.text,events.first.eventInfo!.eventId);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Text("Apply"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (controller.promoCodeList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        primary: false,
                        itemCount: controller.promoCodeList.first.data!.length,
                        itemBuilder: (ctx, index) => Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: PromoCard(
                              promo:
                                  controller.promoCodeList.first.data![index],
                              apply: () {
                                controller.applied(
                                    controller.promoCodeList.first.data![index]
                                        .promoCode,
                                    controller.promoCodeList.first.data![index]
                                        .eventId);
                              }),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            );
    });
  }
}

class PromoCard extends StatelessWidget {
  final VoidCallback apply;
  const PromoCard({
    super.key,
    required this.promo,
    required this.apply,
  });
  final Data promo;

  @override
  Widget build(BuildContext context) {
    TextStyle smallText = Theme.of(context).textTheme.headlineSmall!;
    TextStyle headingText =
        Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13);
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
          border: Border.all(width: 0.26),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promo.promoCode.toString(),
                      style: headingText,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      promo.promoName.toString(),
                      style: smallText,
                    ),
                  ]),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: apply,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryColor),
                    borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    "Apply",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
