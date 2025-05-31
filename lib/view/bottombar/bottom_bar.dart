import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sambanew/controller/homeController.dart';
import 'package:sambanew/theme/apptheme.dart';
import 'package:sambanew/view/event/allevents.dart';

import '../home/homepage.dart';
import '../profile/profile.dart';
import '../tickets/tickets_tab.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageController>(
      builder: (controller) => Scaffold(
        //   backgroundColor: Colors.grey.shade100,
        body: IndexedStack(
          index: controller.tabIndex,
          children: [
            const Home(),
            const AllEvents(),
            TicketsTab(),
            const Profile(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Get.theme.cardColor,
          elevation: 0,
          selectedLabelStyle: GoogleFonts.inter(
            //  color: Get.theme.cardColor,
            fontSize: 12, height: 2,
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
          ),
          unselectedItemColor: AppTheme.hintTextColor,
          unselectedIconTheme: IconThemeData(color: AppTheme.hintTextColor),
          selectedIconTheme: IconThemeData(color: AppTheme.primaryColor),
          selectedItemColor: AppTheme.primaryColor,
          unselectedLabelStyle: GoogleFonts.inter(
            // color: AppTheme.blueColor,
            fontSize: 12,
            letterSpacing: 0, height: 2,
            fontWeight: FontWeight.w500,
          ),
          iconSize: 22,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.search), label: 'AllEvents'.tr),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/icons/ticket2.svg",
                  color: AppTheme.primaryColor,
                ),
                icon: SvgPicture.asset("assets/icons/ticket2.svg"),
                label: 'tickets'.tr),
             BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.profile_circled), label: 'profile'.tr)
          ],
          onTap: (val) {
             controller.changeTabIndex(val);
            // Get.offAll(LoadingPaymentpgae(
            //     sno: "sid20240812180904769071",
            //     netTotal: 50,
            //     tno: "1723486152019", bkno: "BN240813244AI2K"
            //   ));
          },
          currentIndex: controller.tabIndex,
        ),
      ),
    );
  }
}
//abnikagarg@192 tickternew % flutter build web --no-tree-shake-icons --web-renderer auto --release                   