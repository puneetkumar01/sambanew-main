import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sambanew/view/tickets/tickets_page.dart';

import '../../components/button.dart';
import '../../controller/homeController.dart';
import '../../service/shared_pref.dart';
import '../../theme/apptheme.dart';
import '../../util/config.dart';

class TicketsTab extends StatelessWidget {
  TicketsTab({
    super.key,
  });
  final wcontroller = Get.put<HomepageController>(HomepageController());

  @override
  Widget build(BuildContext context) {
    return !PreferenceUtils.isLoggedIn()
        ? Scaffold(
            appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Booking History",
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(100),
                  ),
                  Text(
                    "Check your booking history".tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(28),
                    ),
                    child: Button(
                      tittle: "sign_in".tr,
                      tap: () {
                        Get.toNamed("/login");
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              backgroundColor: Get.theme.cardColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(child: Container()),
                              TabBar(
                                dividerColor: Colors.transparent,
                                indicatorSize: TabBarIndicatorSize.tab,
                                isScrollable: false,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 16),
                                unselectedLabelColor: AppTheme.lightTextColor,
                                tabs: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text("upcoming_tickets".tr),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text("past_tickets".tr),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: const TabBarView(children: [
                TicketPage(type: 1),
                TicketPage(type: 2),
              ]),
            ));
    // : Scaffold(
    //     appBar: AppBar(   backgroundColor: Get.theme.cardColor,
    //         elevation: 0,
    //         centerTitle: true,
    //         title: Text(
    //           "Booking History",
    //           style: Theme.of(context).textTheme.headlineMedium,
    //         )),
    //    // backgroundColor: AppTheme.ticketBackground,
    //     body: TicketPage(),
    //   );
  }
}
