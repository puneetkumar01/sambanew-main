import 'package:get/get.dart';
import 'package:sambanew/controller/authController.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  
  }
}