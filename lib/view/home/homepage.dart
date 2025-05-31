import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/homeController.dart';
import 'package:sambanew/theme/apptheme.dart';
import 'package:sambanew/util/config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sambanew/view/home/components/homeshimmer.dart';
import 'package:sambanew/view/home/components/new_eventcard.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// List categories = [
//   {"image": "sports.png", "title": "Sports"},
//   {"image": "Theater.png", "title": "Theater"},
//   {"image": "music.png", "title": "Music"},
//   {"image": "business.png", "title": "Business"},
//   {"image": "sports.png", "title": "Sports"}
// ];
// List upcomingEvent = [
//   {"image": "today.png", "title": "HAPPENING TODAY"},
//   {"image": "tommorow.png", "title": "PLAN FOR TOMORROW"},
//   {"image": "today.png", "title": "THIS WEEKEND"},
//   {"image": "month.png", "title": "ALL EVENTS THIS MONTH"}
// ];

class _HomeState extends State<Home> {
  final int _current = 0;
  final wcontroller = Get.put<HomepageController>(HomepageController());
CarouselSliderController buttonCarouselController = CarouselSliderController();
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Get.theme.cardColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          titleSpacing: 10,
          //backgroundColor: Get.theme.cardColor,
          actions: const [
            // Container(
            //   margin: EdgeInsets.only(right: 20),
            //   width: getProportionateScreenWidth(32),
            //   height: getProportionateScreenHeight(32),
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: AppTheme.whiteBackgroundColor.withOpacity(0.2)),
            //   child: Icon(
            //     Icons.notifications_none_outlined,
            //     size: 20,
            //     color: AppTheme.whiteBackgroundColor,
            //   ),
            // )
          ],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/aa.jpeg",
               // height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
              // Text(
              //   "  Samba ${'events'.tr}",
              //   style: TextStyle(
              //     height: 0,
              //   ),
              // ),
            ],
          ),
          // title: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Row(
          //     //   mainAxisSize: MainAxisSize.min,
          //     //   mainAxisAlignment: MainAxisAlignment.center,
          //     //   children: [
          //     //     Text(
          //     //       "Current Location",
          //     //       style: Theme.of(context).textTheme.labelSmall!.copyWith(
          //     //           fontSize: 12, color: AppTheme.whiteBackgroundColor),
          //     //     ),
          //     //     Icon(
          //     //       Icons.arrow_drop_down,
          //     //       size: 22,
          //     //       color: AppTheme.whiteBackgroundColor,
          //     //     )
          //     //   ],
          //     // ),
          //     Text(
          //       "Samba",
          //       style: Theme.of(context)
          //           .textTheme
          //           .bodySmall!
          //           .copyWith(fontSize: 16, color: AppTheme.homePagecolor1),
          //     ),
          //   ],
          // ),
        ),
        body: GetBuilder<HomepageController>(builder: (controller) {
          return controller.isLoaded
              ? Column(
                  children: [
                    Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            // color: Get.theme.cardColor,
                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(33),ShimmerWidget
                            //     bottomRight: Radius.circular(33))
                            ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(2),
                            ),
                            //
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(
                            //     "Device Locale :${Get.locale!.languageCode}",
                            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            //   ),
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                    child: TextFormField(
                                      cursorColor: AppTheme.blueColor,
                                      //style: TextStyle(fontSize: 14),
                                      readOnly: true,
                                      onTap: () {
                                        controller.onTapSearchbox();
                                      },
                                      decoration: InputDecoration(
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: AppTheme
                                                      .whiteBackgroundColor
                                                      .withOpacity(0.6)),
                                          icon: Icon(
                                            Icons.search,
                                            color:
                                                AppTheme.whiteBackgroundColor,
                                          ),
                                          hintText: "${'search'.tr}..",
                                          isDense: true,
                                          fillColor: Colors.white,
                                          filled: true,
                                          contentPadding: const EdgeInsets.all(3),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(right: 12.w),
                                //   child: InkWell(
                                //     onTap: () {
                                //       ModelBottomSheet.showFilterModal(context);
                                //     },
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //           color: AppTheme.whiteBackgroundColor,
                                //           borderRadius:
                                //               BorderRadius.circular(50)),
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(6),
                                //             child: Container(
                                //               decoration: BoxDecoration(
                                //                   color: AppTheme.primaryColor,
                                //                   shape: BoxShape.circle),
                                //               child: Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(2),
                                //                 child: Icon(
                                //                   Icons.filter_list_sharp,
                                //                   size: 20,
                                //                   color: AppTheme
                                //                       .whiteBackgroundColor,
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //           Text(
                                //             " Filters  ",
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .bodySmall!
                                //                 .copyWith(
                                //                     fontSize: 12,
                                //                     color:
                                //                         AppTheme.darkTextColor),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        )),
                     Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (controller.eventCategory.isNotEmpty)
                              SizedBox(
                                width: double.infinity,
                                // color: Colors.white,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        controller.eventCategory.length,
                                        (index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 10,
                                            left: index == 0 ? 20.w : 20.w),
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            controller.filterEvents(controller
                                                .eventCategory[index]
                                                .eventTypeId
                                                .toString());
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        14),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Get.theme.cardColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color(0x8C333335)
                                                            .withOpacity(0.2),
                                                        offset: const Offset(
                                                          0.0,
                                                          1.0,
                                                        ),
                                                        blurRadius: 4.0,
                                                        spreadRadius: 3),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(9.0),
                                                  child: Image.network(
                                                      "${controller.eventCategory[index].imagePath.toString()}${controller.eventCategory[index].imageName.toString()}"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                controller.eventCategory[index]
                                                    .eventType
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(fontSize: 13),
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
                            // if (controller.bannerImages.isNotEmpty)
                            //   Stack(
                            //     children: [
                            //       CarouselSlider.builder(
                            //           itemCount: controller.bannerImages.length,
                            //           itemBuilder: (context, index, realIndex) {
                            //             return Stack(
                            //               children: <Widget>[
                            //                 ShaderMask(
                            //                   shaderCallback: (rect) {
                            //                     return const LinearGradient(
                            //                       begin: Alignment.topCenter,
                            //                       end: Alignment.bottomCenter,
                            //                       colors: [
                            //                         Color.fromRGBO(
                            //                             0, 57, 149, 1),
                            //                         Color.fromRGBO(
                            //                             0, 41, 161, 1),
                            //                       ],
                            //                     ).createShader(Rect.fromLTRB(
                            //                         10,
                            //                         0,
                            //                         rect.width,
                            //                         rect.height));
                            //                   },
                            //                   blendMode: BlendMode.dstOver,
                            //                   child: AspectRatio(
                            //                     aspectRatio: 2 / 1,
                            //                     child: Image.network(
                            //                       controller.bannerImages[index]
                            //                               [
                            //                               "frontSliderImagePath"] +
                            //                           controller.bannerImages[
                            //                                   index]
                            //                               ["frontSliderImage"],
                            //                       fit: BoxFit.cover,
                            //                       colorBlendMode:
                            //                           BlendMode.dstATop,
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 // Positioned(
                            //                 //   bottom: 12.h,
                            //                 //   left: 10.w,
                            //                 //   right: 0.0,
                            //                 //   child: Column(
                            //                 //     crossAxisAlignment: CrossAxisAlignment.start,
                            //                 //     children: [
                            //                 //       Text('FRIDAY AUG 24, 9PM',
                            //                 //           style: GoogleFonts.inter(
                            //                 //             color: AppTheme.whiteBackgroundColor,
                            //                 //             fontSize: 12,
                            //                 //           )),
                            //                 //       Text('Brightlight Music Festival',
                            //                 //           style: GoogleFonts.inter(
                            //                 //             color: AppTheme.whiteBackgroundColor,
                            //                 //             fontSize: 22,
                            //                 //           )),
                            //                 //       Row(
                            //                 //         children: [
                            //                 //           SvgPicture.asset("assets/icons/location.svg",
                            //                 //               fit: BoxFit.scaleDown),
                            //                 //           Text(' Singapore Stadium',
                            //                 //               style: GoogleFonts.inter(
                            //                 //                 color: AppTheme.whiteBackgroundColor,
                            //                 //                 fontSize: 12,
                            //                 //               )),
                            //                 //           SizedBox(
                            //                 //             width: 10.w,
                            //                 //           ),
                            //                 //           SvgPicture.asset("assets/icons/ticketer.svg",
                            //                 //               fit: BoxFit.scaleDown),
                            //                 //           Text('€40 - €90',
                            //                 //               style: GoogleFonts.inter(
                            //                 //                 color: AppTheme.whiteBackgroundColor,
                            //                 //                 fontSize: 12,
                            //                 //               )),
                            //                 //         ],
                            //                 //       ),
                            //                 //     ],
                            //                 //   ),
                            //                 // ),
                            //               ],
                            //             );
                            //           },
                            //           options: CarouselOptions(
                            //             //  height: getProportionateScreenHeight(300),
                            //             aspectRatio: 2 / 1,
                            //             viewportFraction: 1,
                            //             initialPage: 0,
                            //             onPageChanged: (index, reason) {
                            //               setState(() {
                            //                 _current = index;
                            //               });
                            //             },
                            //             enableInfiniteScroll: true,
                            //             reverse: false,
                            //             autoPlay: true,
                            //             autoPlayInterval: Duration(seconds: 3),
                            //             autoPlayAnimationDuration:
                            //                 Duration(milliseconds: 800),
                            //             autoPlayCurve: Curves.fastOutSlowIn,
                            //             enlargeCenterPage: true,
                            //             // onPageChanged: pageController,
                            //             scrollDirection: Axis.horizontal,
                            //           )),
                            //       Positioned.fill(
                            //         bottom: 5.h,
                            //         child: Align(
                            //           alignment: Alignment.bottomCenter,
                            //           child: Container(
                            //             child: DotsIndicator(
                            //               dotsCount:
                            //                   controller.bannerImages.length,
                            //               position: _current,
                            //               decorator: DotsDecorator(
                            //                 size: const Size.square(9.0),
                            //                 activeColor:
                            //                     AppTheme.whiteBackgroundColor,
                            //                 activeSize: const Size(18.0, 9.0),
                            //                 activeShape: RoundedRectangleBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(5.0)),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // SizedBox(
                            //   height: 12,
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: HeadLine(
                                subtext: 'discover_more!'.tr,
                                title: "head_out_this_weekend!".tr,
                                ontap: () {
                                  controller.openNewTab();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (controller.topEventsData.isNotEmpty)
                              SizedBox(
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        controller.topEventsData.length,
                                        (index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: index == 0 ? 14 : 20),
                                        child: InkWell(
                                          onTap: () {
                                            // Get.offAll(LoadingPaymentpgae(sno: 'sid20240613130826798435', tno: '', netTotal: 60.00,));
                                            //LoadingPaymentpgae
                                            Get.toNamed(
                                                "/eventDetail/${controller.topEventsData[index].eventInfo!.eventCode}");
                                          },
                                          child: EventCard(
                                            events:
                                                controller.topEventsData[index],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: getProportionateScreenWidth(12),
                            //       vertical: getProportionateScreenHeight(12)),
                            //   child: HeadLine(subtext: "See all", title: "Upcoming events"),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: getProportionateScreenWidth(10),
                            //   ),
                            //   child: GridView.builder(
                            //     shrinkWrap: true,
                            //     physics: NeverScrollableScrollPhysics(),
                            //     itemCount: upcomingEvent.length,
                            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //       crossAxisCount: 2,
                            //       childAspectRatio: 2 / 1.1,
                            //     ),
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return Padding(
                            //         padding: const EdgeInsets.all(6),
                            //         child: GestureDetector(
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.circular(10),
                            //               gradient: const LinearGradient(
                            //                   colors: [
                            //                     Color.fromRGBO(41, 141, 214, 1),
                            //                     Color.fromRGBO(220, 240, 255, 1),
                            //                   ],
                            //                   begin: Alignment.topCenter,
                            //                   end: Alignment.bottomCenter,
                            //                   tileMode: TileMode.clamp),
                            //             ),
                            //             child: Row(
                            //               children: [
                            //                 Image.asset(
                            //                     fit: BoxFit.cover,
                            //                     "assets/images/${upcomingEvent[index]["image"]}"),
                            //                 Flexible(
                            //                   child: Text(upcomingEvent[index]["title"],
                            //                       style: Theme.of(context)
                            //                           .textTheme
                            //                           .bodySmall!
                            //                           .copyWith(fontSize: 10)),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           onTap: () {},
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: getProportionateScreenWidth(12),
                            //       vertical: getProportionateScreenHeight(12)),
                            //   child: HeadLine(subtext: "See all", title: "Ready to Party?"),
                            // ),
                            // Container(
                            //   width: double.infinity,
                            //   color: Colors.white,
                            //   child: SingleChildScrollView(
                            //     scrollDirection: Axis.horizontal,
                            //     child: Row(
                            //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: List.generate(categories.length, (index) {
                            //         return Padding(
                            //           padding: EdgeInsets.only(left: index == 0 ? 14.w : 10.w),
                            //           child: InkWell(
                            //             onTap: () {
                            //               Get.to(EventDetails());
                            //             },
                            //             child: EventCard(),
                            //           ),
                            //         );
                            //       }),
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: getProportionateScreenWidth(12),
                            //       vertical: getProportionateScreenHeight(12)),
                            //   child:
                            //       HeadLine(subtext: "See all", title: "Explore Fun Activities"),
                            // ),
                            // Container(
                            //   width: double.infinity,
                            //   color: Colors.white,
                            //   child: SingleChildScrollView(
                            //     scrollDirection: Axis.horizontal,
                            //     child: Row(
                            //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: List.generate(categories.length, (index) {
                            //         return Padding(
                            //           padding: EdgeInsets.only(left: index == 0 ? 14.w : 10.w),
                            //           child: InkWell(
                            //             onTap: () {
                            //               Get.to(EventDetails());
                            //             },
                            //             child: EventCard(),
                            //           ),
                            //         );
                            //       }),
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: getProportionateScreenWidth(12),
                            //       vertical: getProportionateScreenHeight(12)),
                            //   child: HeadLine(subtext: "See all", title: "Laugh Out Loud"),
                            // ),
                            // Container(
                            //   width: double.infinity,
                            //   color: Colors.white,
                            //   child: SingleChildScrollView(
                            //     scrollDirection: Axis.horizontal,
                            //     child: Row(
                            //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: List.generate(categories.length, (index) {
                            //         return Padding(
                            //           padding: EdgeInsets.only(left: index == 0 ? 14.w : 10.w),
                            //           child: InkWell(
                            //             onTap: () {
                            //               Get.to(EventDetails());
                            //             },
                            //             child: EventCard(),
                            //           ),
                            //         );
                            //       }),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const ShimmerWidget();
        }));
  }
}

class HeadLine extends StatelessWidget {
  HeadLine({
    super.key,
    required this.ontap,
    required this.title,
    required this.subtext,
  });
  final String title;
  VoidCallback ontap;
  final String subtext;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset(
            //   "assets/icons/Search.png",
            //   height: 18,
            //   color: Get.theme.canvasColor,
            // ),
            // SizedBox(
            //   width: 6,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 16),
                ),
                Text(
                  subtext,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        //headingText
        GestureDetector(
          onTap: ontap,
          child: Row(
            children: [
              Text(
                'see_all'.tr,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontSize: 13),
              ),
              const SizedBox(
                width: 2,
              ),
              Icon(
                Icons.arrow_forward,
                color: AppTheme.primaryColor,
                size: 16,
              )
            ],
          ),
        )
      ],
    );
  }
}

// Widget buildLabel({
//   required String label,
//   required Color color,
// }) =>
//     Text(
//       label,
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.w400,
//       ).copyWith(color: color),
//     );

// class Utils {
//   static List<Widget> modelBuilder<M>(
//           List<M> models, Widget Function(int index, M model) builder) =>
//       models
//           .asMap()
//           .map<int, Widget>(
//               (index, model) => MapEntry(index, builder(index, model)))
//           .values
//           .toList();
// }
