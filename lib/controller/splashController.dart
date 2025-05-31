import 'dart:async';
import 'package:get/get.dart';

import '../service/shared_pref.dart';
import '../util/app_images.dart';

class SplashController extends GetxController {
  SplashController();
  final image = Images.logo;

  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 2), () {
      if (PreferenceUtils.isLoggedIn()) {
        Get.offAllNamed("/");
      } else {
        Get.offAllNamed("/login");
      }
    });
  }
}
