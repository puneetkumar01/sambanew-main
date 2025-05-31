import 'package:get/get.dart';
import 'package:sambanew/controller/eventController.dart';
import '../controller/homeController.dart';


class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(() => HomepageController());
    Get.lazyPut<Eventcontroller>(() => Eventcontroller());
  
  }
}