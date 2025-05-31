import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sambanew/service/shared_pref.dart';

import '../util/app_urls.dart';

class AuthService {
  AuthService() {
    print("object");
  }
  final String noInternetMessage =
      'Connection to API server failed due to internet connection';
  Future<Response> apiLoginService(String? email, String? Password) async {
    var ur = Uri.parse(AppUrls.baseLoginUrl + AppUrls.loginUrl);
    try {
      final response2 = await http.post(ur,
          body: jsonEncode({
            "email": email,
            "userPassword": Password,
            "isApple": false,
            "isGoogle": false,
            "isFacebook": false,
            "logincode": ""
          }),
          headers: {
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

  Future<Response> apiSignUpService(
      String? name, String? email, String? password) async {
    var ur = Uri.parse(AppUrls.baseLoginUrl + AppUrls.signupUrl);

    try {
      final response2 = await http.post(ur,
          body: jsonEncode({
            "customerId": 0,
            "firstName": name,
            "email": email,
            "password": password,
            "isGmail": false,
            "isFacebook": false,
            "isApple": false,
            "logincode": ""
          }),
          headers: {
            "content-type": "application/json",
          });
      if (kDebugMode) {
        print(response2.body);
      }
      // if (response2.statusCode == 200) {
      //   var data2 = jsonDecode(response2.body);
      //   if (data2['success'] == 1) {
      //     apiSentMailService(
      //         data2["data"]['customerId'],  false);
      //   }
      // }
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

  Future<Response> apiSentMailService(String? customerId, bool? isResend) async {
    var ur = Uri.parse(AppUrls.baseUrlMail + AppUrls.sendLoginMail);
    try {
      final response2 = await http.post(ur,
          body: jsonEncode({"customerId": int.parse(customerId.toString()), "isResend": isResend}),
          headers: {
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
   Future<Response> apiResetPassword(String? email) async {
    var ur = Uri.parse(AppUrls.baseUrlMail + AppUrls.resetPassword);
    try {
      final response2 = await http.post(ur,
          body: jsonEncode({"emailId": email,}),
          headers: {
            "content-type": "application/json",
          });
      if (kDebugMode) {
        print(response2.body);
      }
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

  Future<Response> apiVerifyOtpService(String? otp, String? customerId) async {
    var ur = Uri.parse(AppUrls.baseUrlMail + AppUrls.verifyAccount);
    try { var token = PreferenceUtils.getString("token");
      final response2 = await http.post(ur,
          body: jsonEncode({"customerId": customerId, "code": otp}),
          headers: {
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

  Future<Response> apiVerifySocialLogins(
      String? lc, String? email, String? type) async {
    var ur = Uri.parse(AppUrls.baseLoginUrl + AppUrls.socialLogins);
    try {
      final response2 = await http.post(ur,
          body:
              jsonEncode({"logincode": lc, "email": email, "loginfrom": type}),
          headers: {
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
//https://apiticketernewmail.ticketer.sg/swagger/index.html
//https://apiticketernew.ticketer.sg/swagger/index.html