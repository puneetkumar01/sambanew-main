import 'package:get/get.dart';
import '../controller/ticketsController.dart';


class TicketBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketController>(() => TicketController());
  
  }
}