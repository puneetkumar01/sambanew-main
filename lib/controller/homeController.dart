import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sambanew/models/BookingHistoryModel.dart';
import 'package:sambanew/models/EventModel.dart';
import 'package:sambanew/service/event_repo.dart';
import '../components/dialogs.dart';
import '../models/EventCatModel.dart';
import '../models/EventLikeModel.dart';
import '../models/VendorListModel.dart';

class HomepageController extends GetxController {
  var tabIndex = 0;
  final parameters = Get.parameters;
  void changeTabIndex(int index) {
    tabIndex = index;
    debugPrint(index.toString());
    if (index == 2 && !isLoadedBookings) {
      getBookingHistory();
    }
    if (index == 3 && !isLoadedProfile) {
      getLikedEvents();
      gettFollowers();
    }

    update();
  }

  final searchController = TextEditingController();
  FocusNode focus = FocusNode();
  @override
  void onInit() {
    if (parameters.isNotEmpty) {
      tabIndex = int.parse(parameters["pageIndex"].toString());
      update();
      getBookingHistory();
    }
    super.onInit();
    getBanners();
    getEventTypes();
    getTopEvents("0");
    getEvents("0");
  }

  openNewTab() {
    tabIndex = 1;
    update();
  }

  onTapSearchbox() {
    tabIndex = 1;
    focus.requestFocus();
    update();
  }


  List bannerImages = [];
  void getBanners() async {
    bannerImages.clear();

    service.apiGetBanner().then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.data);

          bannerImages = decodedData["data"];
          // eventData = allEvents.first.data!;
          // if (allPostList.first.data!.items!.isEmpty) {
          //   hasNextPage = false;
          // }
          update();
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

  List<EventModel> allEvents = [];
  bool isLoaded = false;
  List<Data> eventData = [];
  String eventSelectedTypes = "0";
  bool isLoadedAllEvents = false;
  final service = EventService();
  getEvents(type) async {
    var value = await service.apiGetEvents("$type", "0", 1, 100).then((value) {
      allEvents.clear();
      switch (value.statusCode) {
        case 200:
          isLoadedAllEvents = true;
          final decodedData = jsonDecode(value.data);
          print("object");
          allEvents.add(EventModel.fromJson(decodedData));

          eventData = allEvents.first.data!;

          // if (allPostList.first.data!.items!.isEmpty) {
          //   hasNextPage = false;
          // }

          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isLoadedAllEvents = true;
          eventData.clear();
          update();
          break;
      }
    });
  }

  List<EventModel> topEvents = [];

  List<Data> topEventsData = [];
  void getTopEvents(type) async {
    topEvents.clear();

    service.apiGetEvents(type, "0", 1, 5).then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.data);

          topEvents.add(EventModel.fromJson(decodedData));

          topEventsData = topEvents.first.data!;

          // if (allPostList.first.data!.items!.isEmpty) {
          //   hasNextPage = false;
          // }

          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isLoaded = true;
          update();
          break;
      }
    });
  }

  List<EventCatModel> eventTypes = List.empty(growable: true);
  List<EventTypes> eventCategory = List.empty(growable: true);

  void getEventTypes() async {
    eventTypes.clear();

    service.apiGetEventTypes().then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.data);
          eventTypes.add(EventCatModel.fromJson(decodedData));
          eventCategory = eventTypes.first.eventTypes!;
          // eventData = allEvents.first.data!;
          // if (allPostList.first.data!.items!.isEmpty) {
          //   hasNextPage = false;
          // }
          update();
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

  List selectedEventTypes = [];
  filterEvents(type) {
    tabIndex = 1;
    eventSelectedTypes = type;
    selectedEventTypes = [int.parse(type)];
    isLoadedAllEvents = false;
    filterApplied = true;
    eventData.clear();
    update();
    getEvents("$type");
  }

  selectedFilter(index) {
    if (selectedEventTypes.contains(index)) {
      selectedEventTypes.remove(index);
    } else {
      selectedEventTypes.add(index);
    }

    eventSelectedTypes = selectedEventTypes.join(', ');
    print(eventSelectedTypes);
    update();
  }

  bool filterApplied = false;
  applyFilter() async {
    if (eventSelectedTypes == "" || eventSelectedTypes == "0") {
      eventSelectedTypes = "0";
      filterApplied = false;
    } else {
      filterApplied = true;
    }
    searchController.clear();
    await getEvents(eventSelectedTypes);
    dateFilter();

    Get.back();
  }

  dateFilter() {
    filterApplied = true;
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime weekendStart = now.add(Duration(days: (6 - now.weekday) % 7));
    DateTime weekendEnd = weekendStart.add(const Duration(days: 1));
    if (filters.isNotEmpty) {
      eventData = allEvents.first.data!.where((event) {
        if (filters.contains('today') &&
            DateTime.parse(event.eventInfo!.startDate.toString()).day ==
                now.day) {
          return true;
        }
        if (filters.contains('tomorrow') &&
            DateTime.parse(event.eventInfo!.startDate.toString()).day ==
                tomorrow.day) {
          return true;
        }
        if (filters.contains('weekend') &&
            DateTime.parse(event.eventInfo!.startDate.toString())
                .isAfter(weekendStart) &&
            DateTime.parse(event.eventInfo!.startDate.toString())
                .isBefore(weekendEnd)) {
          return true;
        }
        return filters.isEmpty;
      }).toList();
    }
    eventData = allEvents.first.data!.where((event) {
      return event.eventInfo!.ticketPriceOnward! >= currentRangeValues.start &&
          event.eventInfo!.ticketPriceOnward! <= currentRangeValues.end;
    }).toList();
    update();
  }

  cancelFilter() {
    eventSelectedTypes = "";
    filters.clear();
    selectedEventTypes.clear();
    filterApplied = false;
    getEvents("0");
    Get.back();
  }

  bool isLoadedBookings = false;
  List<BookingHistoryModel> bookingHistory = [];
  List<BookingHistoryModelData> bookingUpHistory = [];
  List<BookingHistoryModelData> bookingPastHistory = [];
  void getBookingHistory() async {
    bookingHistory.clear();

    service.apiGetBookingHistory().then((value) {
      switch (value.statusCode) {
        case 200:
          isLoadedBookings = true;
          final decodedData = jsonDecode(value.data);
          bookingHistory.add(BookingHistoryModel.fromJson(decodedData));
          bookingUpHistory = bookingHistory.first.data!
              .where((elem) => elem.eventStatus != "Previous")
              .toList();
          bookingPastHistory = bookingHistory.first.data!
              .where((elem) => elem.eventStatus == "Previous")
              .toList();
          update();
          //Previous
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

  List privacyPolicy = [];

  void getPrivacyPolicy() async {
    service.apiGetPrivacy().then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          privacyPolicy = decodedData["data"];

          update();
          break;

        case 1:
          break;
        default:
          break;
      }
    });
  }

  List purchasePolicy = [];

  void getPurchasePolicy() async {
    service.apiGetPurshase().then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          purchasePolicy = decodedData["data"];

          update();
          break;

        case 1:
          break;
        default:
          break;
      }
    });
  }

  searchList(String query) async {
    if (allEvents.isEmpty) {
      return;
    }
    if (query.isNotEmpty) {
      eventData = allEvents.first.data!
          .where((elem) =>
              elem.eventInfo!.eventName!.toLowerCase().contains(query))
          .toList();
    } else {
      eventData = allEvents.first.data!;
    }
    update();
  }

  int selctedDates = -1;
  selectDates(index) {
    selctedDates = index;
    update();
  }

  filterDateEvents(DateTime filterDate) {
    eventData = eventData
        .where((event) => DateTime.parse(event.eventInfo!.startDate.toString())
            .isAtSameMomentAs(filterDate))
        .toList();
    update();
  }

  List<EventLikeModelData> likeEventList = [];
  bool isLoadedProfile = false;
  void getLikedEvents() async { isLoadedProfile = false;
  update();
    likeEventList.clear();
    service.apiGetEventsSaved().then((value) {
      switch (value.statusCode) {
        case 200:
          isLoadedProfile = true;
          final decodedData = jsonDecode(value.data);
          List<EventLikeModel> EventList = [];
          EventList.add(EventLikeModel.fromJson(decodedData));

          likeEventList = EventList.first.data!;

          // if (allPostList.first.data!.items!.isEmpty) {
          //   hasNextPage = false;
          // }

          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isLoadedProfile = true;
          update();
          break;
      }
    });
  }

  List<VendorListModelData> vndorFollwers = [];
  bool isloadedVendors=false;
  void gettFollowers() async { 
  isloadedVendors=false; update();
    vndorFollwers.clear();
    service.apiGetFollowers().then((value) {
      switch (value.statusCode) {
        case 200:
         isloadedVendors=true;
          final decodedData = jsonDecode(value.data);
          List<VendorListModel> VendorList = [];
          VendorList.add(VendorListModel.fromJson(decodedData));
          vndorFollwers = VendorList.first.data!;
          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default: isloadedVendors=true; update();
          vndorFollwers.clear();
          break;
      }
    });
  }

  void deleteAccount() async {
    DialogHelper.showLoading();
    service.apiDeleteAccount().then((value) {
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          Get.offAndToNamed("/login");

          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          DialogHelper.showError("Something went wrong");
          break;
      }
    });
  }

  Set<String> filters = {};

  void toggleFilter(String filter) {
    if (filters.contains(filter)) {
      filters.remove(filter);
    } else {
      filters.add(filter);
    }
    update();
  }

  RangeValues currentRangeValues = const RangeValues(0, 50000);
  onchangeFilter(value) {
    currentRangeValues = value;
    update();
  }

  followVendor(code, follow) {
    int index = vndorFollwers.indexWhere(
        (element) => element.vendorId.toString() == code.toString());
    vndorFollwers[index].vendorfollowtag = follow == 0 ? 1 : 0;
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

  likeEvent(code) {
    service.apiLikeEvent(code).then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
            DialogHelper.showErroDialog(
                description: "Removed");
          getLikedEvents();
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
}
