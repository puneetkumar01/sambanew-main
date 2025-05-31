import 'package:get/get.dart';
import 'package:sambanew/controller/vendorController.dart';

class VendorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Vendorcontroller>(() => Vendorcontroller());
  
  }
}