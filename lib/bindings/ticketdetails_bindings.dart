import 'package:get/get.dart';

import '../controller/bookingHistoryController.dart';



class TicketDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingHistoryController>(() => BookingHistoryController());
  
  }
}