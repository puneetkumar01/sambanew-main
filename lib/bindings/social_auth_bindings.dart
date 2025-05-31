import 'package:get/get.dart';
import 'package:sambanew/controller/socialController.dart';

class SocialAuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthSocialController>(() => AuthSocialController());
  
  }
}