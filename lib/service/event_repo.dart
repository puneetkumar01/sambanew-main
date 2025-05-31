import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sambanew/service/shared_pref.dart';

import '../util/app_urls.dart';

class EventService {
  final String noInternetMessage =
      'Connection to API server failed due to internet connection';
  Future<Response> apiGetEvents(
      String? typeid, String? eventCode, int pageIndex, int qty) async {
    var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.events}/$typeid/$eventCode/$pageIndex/$qty");
    var token = PreferenceUtils.getString("token");
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetEventsSchdueles(String? eventCode) async {
    var ur =
        Uri.parse("${AppUrls.baseUrl}${AppUrls.schdueleDateTime}/$eventCode");
    var token = PreferenceUtils.getString("token");
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetEventTypes() async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.eventCategory);
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetBanner() async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.getSlidders);
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetPrivacy() async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.getPrivacyPolicy);
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetPurshase() async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.getPurchasePolicy);
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetEventAddon(eventid) async {
    var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.addOn}/$eventid");
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetTickets(eventid, accessCode, schdueleid) async {
    Uri ur;
    if (accessCode != "") {
      ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.eventTicket}/$eventid?accessCode=$accessCode&eventRecurScheduleId=$schdueleid");
    } else {
      ur = Uri.parse(
          "${AppUrls.baseUrl}${AppUrls.eventTicket}/$eventid?eventRecurScheduleId=$schdueleid");
    }
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiCreateCartTicket(eventid, ticketid, qty,schdueleid) async {
    try {
      var session = PreferenceUtils.getString("localSession") == ""
          ? "0"
          : PreferenceUtils.getString("localSession");
      print(session);
      var ur = Uri.parse(AppUrls.baseUrl + AppUrls.createCart);
      final response2 = await http.post(
        ur,
        headers: {
          "content-type": "application/json",
        },
        body: json.encode({
          "customerId": 0,
          "eventId": eventid,
          "eventTicketId": ticketid,
          "productId": 0,
          "eventRecurScheduleId": int.parse(schdueleid),
          "qty": qty,
          "localSessionId": session,
          "prvLocalSessionId": "0",
        }),
      );
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiUpdateCartProduct(
      eventid, productid, qty, count, localSession) async {
    try {
      var ur = Uri.parse(AppUrls.baseUrl + AppUrls.createCart);
      final response2 = await http.post(
        ur,
        headers: {
          "content-type": "application/json",
        },
        body: json.encode({
          "customerId": 0,
          "eventId": eventid,
          "eventTicketId": 0,
          "productId": productid,
          "qty": qty,
          "localSessionId": "$localSession",
          "prvLocalSessionId": count == 1 ? "$localSession" : "0",
        }),
      );
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiCreateCartProduct(eventid, productid, qty) async {
    try {
      var session = PreferenceUtils.getString("localSession") == ""
          ? "0"
          : PreferenceUtils.getString("localSession");
      var ur = Uri.parse(AppUrls.baseUrl + AppUrls.createCart);
      final response2 = await http.post(
        ur,
        headers: {
          "content-type": "application/json",
        },
        body: json.encode({
          "customerId": 0,
          "eventId": eventid,
          "eventTicketId": 0,
          "productId": productid,
          "qty": qty,
          "localSessionId": session,
          "prvLocalSessionId": session,
        }),
      );
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetCart() async {
    // var token = PreferenceUtils.getUserToken();
    var session = PreferenceUtils.getString("localSession");
    var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.fetchCart}/$session");
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",

        ///'Authorization': 'Bearer $token',
      });

      print(response2.body);

      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiDeleteCart(sessionid) async {
    // var token = PreferenceUtils.getUserToken();

    var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.deletCart}/$sessionid");
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",

        ///'Authorization': 'Bearer $token',
      });

      print(response2.body);

      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetVendorDetail(vendorCode) async {
    try {
      var ur =
          Uri.parse("${AppUrls.baseUrl}${AppUrls.getVendorDetail}/$vendorCode");
      var token = PreferenceUtils.getString("token");
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetBookingHistory() async {
    var token = PreferenceUtils.getString("token");
    var session = PreferenceUtils.getString("localSession");
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.getBookings);
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });

      print(response2.body);

      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetTicketsHistory(bookingNo) async {
    // var token = PreferenceUtils.getUserToken();
    var session = PreferenceUtils.getString("localSession");
    var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.getTickets}/$bookingNo");
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",

        ///'Authorization': 'Bearer $token',
      });

      print(response2.body);

      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetPromoCodes(eventid) async {
    // var token = PreferenceUtils.getUserToken();
    var session = PreferenceUtils.getString("localSession");
    var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.getPromo}/$eventid");
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",

        ///'Authorization': 'Bearer $token',
      });

      print(response2.body);

      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiApplyPromo(promocode, eventid) async {
    // var token = PreferenceUtils.getUserToken();
    var session = PreferenceUtils.getString("localSession");
    var customerid = PreferenceUtils.getString("customerId") == ""
        ? 0
        : PreferenceUtils.getString("customerId");
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.applyPromo);
    try {
      final response2 = await http.post(ur,
          body: json.encode({
            "promoCode": promocode,
            "customerId": int.parse(customerid.toString()),
            "eventId": int.parse(eventid.toString()),
            "localSessionId": session
          }),
          headers: {
            "content-type": "application/json",

            ///'Authorization': 'Bearer $token',
          });

      print(response2.body);

      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiCheckout(
      eventid, eventCode, netTotal, name, email, mobile,dynamicJsonCheckoutJson) async {
    var token = PreferenceUtils.getString("token");
    var session = PreferenceUtils.getString("localSession");
    var customerid = PreferenceUtils.getString("customerId") == ""
        ? 0
        : PreferenceUtils.getString("customerId");
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.checkout);
    try {
      final response2 = await http.post(ur,
          body: json.encode({
            "customerId": int.parse(customerid.toString()),
            "eventId": int.parse(eventid.toString()),
            "eventCode": "$eventCode",
            "localSessionId": session,
            "netTotal": double.parse(netTotal),
            "paymentTag": 0,
            "name": name,
            "mobile": mobile,
            "email": email,
            "dynamicCheckoutJson": dynamicJsonCheckoutJson.toString(),
            "dynamicCheckoutJsonClean": "",
            "eventPGFeeId": 13,
            "createdUserId": 0,
            "eventUTMLinkCode": "",
            "eventAffiliateCode": "",
            "walletUseTag": 0
          }),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          });

      print(response2.body);

      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiConfirmPayment(
      ssTransactionId, nettotal, bankTransactionId) async {
    var token = PreferenceUtils.getString("token");
    var session = PreferenceUtils.getString("localSession");
    var customerid = PreferenceUtils.getString("customerId") == ""
        ? 0
        : PreferenceUtils.getString("customerId");
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.confirmPayment);
    try {
      final response2 = await http.post(ur,
          body: json.encode({
            "ssTransactionId": ssTransactionId,
            "netTotal": nettotal,
            "bankTransactionId": bankTransactionId
          }),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          });

      print(response2.body);

      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiPaymentGatewayCharges(eventid, eventFeei) async {
    try {
      var session = PreferenceUtils.getString("localSession") == ""
          ? "0"
          : PreferenceUtils.getString("localSession");
      print(session);
      var ur = Uri.parse(AppUrls.baseUrl + AppUrls.paymentGatewayCharges);
      final response2 = await http.post(
        ur,
        headers: {
          "content-type": "application/json",
        },
        body: json.encode({
          "eventPGFeeId": eventFeei,
          "eventId": eventid,
          "localSessionId": session
        }),
      );
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetPaymentGateway(eventid) async {
    try {
      var ur =
          Uri.parse("${AppUrls.baseUrl}${AppUrls.paymentGatwayList}/$eventid");
      final response2 = await http.post(
        ur,
        headers: {
          "content-type": "application/json",
        },
      );
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiLikeEvent(eventCode) async {
    try {
      var token = PreferenceUtils.getString("token");
      var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.likeEvent}/$eventCode");
      final response2 = await http.post(
        ur,
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiFollowVendor(vendor) async {
    try {
      var token = PreferenceUtils.getString("token");
      var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.follow}/$vendor");
      final response2 = await http.post(
        ur,
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetEventsSaved() async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.getLikEvents);
    try {
      var token = PreferenceUtils.getString("token");
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetFollowers() async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.getFollowings);
    try {
      var token = PreferenceUtils.getString("token");
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiDeleteAccount() async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.deleteAccount);
    try {
      var token = PreferenceUtils.getString("token");
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }
   Future<Response> apiGetDynamicJson() async {
        var session = PreferenceUtils.getString("localSession");

    var ur = Uri.parse("${AppUrls.baseUrl}${AppUrls.dynamicJson}/$session");
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }
}
