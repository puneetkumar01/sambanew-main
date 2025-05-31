import 'dart:convert';
import 'package:get/get.dart';
import 'package:sambanew/models/BookingTicketsModel.dart';
import 'package:sambanew/service/event_repo.dart';

class BookingHistoryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getBookingHistory();
  }

  bool isLoadedBookings = false;
  List<BookingTicketsModel> bookingHistory = [];

  int pagecontroller = 0;
  onchange(index) {
    pagecontroller = index;
    update();
  }

  void getBookingHistory() async {
    bookingHistory.clear();

    EventService().apiGetTicketsHistory(Get.parameters["id"]).then((value) {
      switch (value.statusCode) {
        case 200:
          isLoadedBookings = true;
          final decodedData = jsonDecode(value.data);
          bookingHistory.add(BookingTicketsModel.fromJson(decodedData));
       
          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isLoadedBookings = true;
          update();
          break;
      }
    });
  }
}
