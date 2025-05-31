import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../models/EventModel.dart';
import '../models/RecurScheduleModel.dart';
import '../service/event_repo.dart';
import '../service/shared_pref.dart';

class Eventcontroller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getEvents(Get.parameters["id"]); // getEventTypes();
  }

  @override
  void dispose() { scrollController.dispose();
    super.dispose();
  }

  int current = 0;
  updateCuoisel(value) {
    current = value;
    update();
  }

  List<EventModel> allEvents = [];
  bool isLoaded = false;
  bool isShow = false;
  updateSHow() {
    isShow = !isShow;
if(isShow){


    Future.delayed(const Duration(milliseconds: 100), () {
          scrollController.animateTo(
            scrollController.offset + 400, // Adjust the offset to your needs
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
}
    update();
  }

  List<Data> eventData = [];

  final service = EventService();
  void getEvents(eventscode) async {
    allEvents.clear();
    service.apiGetEvents("0", eventscode, 1, 1).then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.data);
          allEvents.add(EventModel.fromJson(decodedData));
          eventData = allEvents.first.data!;
          if (eventData[0].eventInfo!.isRecurringTag!) {
            getEventsSchdueles(eventscode);
          }
          //  getVendorDetails(eventData.first.eventInfo!.vendorCode);
          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          allEvents.clear();

          break;
      }
    });
  }

  List<RecurScheduleModel> eventScheduleData = [];
  void getEventsSchdueles(eventscode) async {
    eventScheduleData.clear();
    service.apiGetEventsSchdueles(eventscode).then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          eventScheduleData.add(RecurScheduleModel.fromJson(decodedData));
          //  getVendorDetails(eventData.first.eventInfo!.vendorCode);
          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          eventScheduleData.clear();

          break;
      }
    });
  }

  int schdeueleid = 0;
  int selectedTimeIndex=0;
  int selectedIndex = 0;
  selectIndex(value,schdeueleid) {
    selectedIndex = value;
    schdeueleid=schdeueleid;
     selectedTimeIndex=0;
    update();
  }
 final ScrollController scrollController = ScrollController();
  selectEventSchduele(value,schdeueleid) {
    selectedTimeIndex=value;
    schdeueleid = schdeueleid;
    update();
  }

  likeEvent(code, like) {
    if (!PreferenceUtils.isLoggedIn()) {
      PreferenceUtils.setString("lastPage", "eventdetails");
      Get.toNamed("/login");
      return;
    }
    eventData.first.eventInfo!.eventLikeTag = like == 0 ? 1 : 0;
    update();
    service.apiLikeEvent(code).then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);

          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          break;
      }
    });
  }

  followVendor(code, follow) {
    if (!PreferenceUtils.isLoggedIn()) {
      PreferenceUtils.setString("lastPage", "eventdetails");
      Get.toNamed("/login");
      return;
    }
    eventData.first.eventInfo!.vendorfollowTag = follow == 0 ? 1 : 0;
    update();
    service.apiFollowVendor(code).then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);

          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          break;
      }
    });
  }
  Future<void> shareContent(name,thumbnailUrl) async {
    try {
      // If you are using a local image, get the file from the device.
      final directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/thumbnail.jpg';

      // Download and save the image locally (for demonstration purposes)
      // Assuming the image is from a URL
      final response = await HttpClient().getUrl(Uri.parse(thumbnailUrl));
      final file = await response.close();
      final bytes = await consolidateHttpClientResponseBytes(file);
      final imageFile = File(filePath);
      await imageFile.writeAsBytes(bytes);

      // Share the image along with the name as text
      Share.shareXFiles([XFile(filePath)], text: "Check out this event: $name");
    } catch (error) {
      print("Error sharing content: $error");
    }
  }
}
