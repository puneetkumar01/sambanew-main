import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/VendorDetails.dart';
import '../service/event_repo.dart';

class Vendorcontroller extends GetxController  with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
    getVendorDetails(Get.arguments['vendorcode']);
  tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  final service = EventService();
  bool isLoaded = false;
  List<VendorDetails> vndorDetails = [];
  void getVendorDetails(vendorCode) async {
    vndorDetails.clear();
    service.apiGetVendorDetail(vendorCode).then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.data);
          vndorDetails.add(VendorDetails.fromJson(decodedData));

          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          vndorDetails.clear();
          break;
      }
    });
  }
  
}
