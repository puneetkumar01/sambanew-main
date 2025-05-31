import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sambanew/components/dialogs.dart';
import '../service/auth_repo.dart';
import '../service/shared_pref.dart';
import '../view/auth/otpScreen.dart';

class AuthController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final service = AuthService();
  final name = TextEditingController();
  final signupEmail = TextEditingController();
  final resetPasswordEmail = TextEditingController();
  final signupPassword = TextEditingController();
  final signupConfirmPass = TextEditingController();
  final pinController = TextEditingController();
  var passwordLoginVisibility = false;
  bool passwordLoginVisibility3 = false;
  bool passwordLoginVisibility2 = false;
  bool isRemember = false;
  @override
  void onInit() {
    super.onInit();
    if (PreferenceUtils.getBool("isremeber") == true) {
      isRemember = true;
      update();
    }
  }


  void showPassword() {
    passwordLoginVisibility = !passwordLoginVisibility;
    update();
  }

  void showPassword2() {
    passwordLoginVisibility2 = !passwordLoginVisibility2;
    update();
  }

  void showPassword3() {
    passwordLoginVisibility3 = !passwordLoginVisibility3;
    update();
  }

  void isRemeberChange() {
    isRemember = !isRemember;

    update();
  }

  void submitLogin() async {
    DialogHelper.showLoading();
    // DialogHelper.showError("Invalid Credentails");
    service.apiLoginService(email.text, password.text).then((value) {
      print(value.data);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.data);
          // response.add(LoginResponse.fromJson(value.data));
          print(data2);

          if (data2["status"].toString() == "1") {
            if (isRemember) {
              PreferenceUtils.setBool("isremeber", isRemember);
              PreferenceUtils.setString("username", email.text);
              PreferenceUtils.setString("password", password.text);
            } else {
              PreferenceUtils().remove("isremeber");
              PreferenceUtils().remove("username");
              PreferenceUtils().remove("password");
            }
            PreferenceUtils.saveUserCustomerId(
                data2["data"]["customerId"].toString());
            PreferenceUtils.setString(
                "name", data2["data"]["firstName"].toString());
            PreferenceUtils.setString(
                "email", data2["data"]["email"].toString());
            PreferenceUtils.setString("mobile", data2["data"]["mobile"] ?? "");
            PreferenceUtils.saveUserToken(data2["data"]["token"].toString());
            if (PreferenceUtils.getString("lastPage") == "eventdetails") {
              PreferenceUtils().remove("lastPage");
              Get.back();
            } else {
              Get.offAllNamed("/");
            }
          } else if (data2["status"].toString() == "2") {
            DialogHelper.showErroRedDialog(
                description: "Email not resgistered with us");
          } else {
            DialogHelper.showErroRedDialog(description: "Invalid Credentails");
          }
          break;
        case 1:
          DialogHelper.showError("No Internet");
          break;
        default:
          DialogHelper.showError("Invalid Credentails");
          break;
      }
    });
  }

  void signUpSubmit() async {
    DialogHelper.showLoading();
    service
        .apiSignUpService(name.text, signupEmail.text, signupConfirmPass.text)
        .then((value) {
      print(value.statusCode);
      // DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.data);
          // response.add(LoginResponse.fromJson(value.data));
          print(data2["success"]);
          if (data2["status"].toString() == "1" && data2["data"] != "") {
            sentotp(data2["data"]["customerId"].toString(), false);
            // Get.to(() =>
            //     OtpScreen(customerid: data2["data"]["customerId"].toString()));
          } else {
            DialogHelper.hideLoading();
            DialogHelper.showErroRedDialog(
                description: data2["message"].toString());
          }
          break;
        case 1:
          DialogHelper.hideLoading();
          DialogHelper.showError("No Internet");
          break;
        default:
          DialogHelper.hideLoading();
          DialogHelper.showError("Something went wrong");
          break;
      }
    });
  }

  void sentotp(customerid, status) async {
    service.apiSentMailService(customerid, status).then((value) {
      print(value.statusCode);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.data);
          // response.add(LoginResponse.fromJson(value.data));
          print(data2["data"]);
          if (data2["status"].toString() == "1") {
            Get.to(() => OtpScreen(customerid: customerid));
          } else {
            DialogHelper.showErroRedDialog(
                description: data2["message"].toString());
          }
          break;
        case 1:
          DialogHelper.showError("No Internet");
          break;
        default:
          DialogHelper.showError("Something went wrong");
          break;
      }
    });
  }

  void resendOtp(customerid, status) async {
    DialogHelper.showLoading();
    service.apiSentMailService(customerid, status).then((value) {
      print(value.statusCode);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.data);
          // response.add(LoginResponse.fromJson(value.data));
          print(data2["data"]);
          if (data2["status"].toString() == "1") {
            DialogHelper.showErroDialog(description: "Otp sent successfully");
          } else {
            DialogHelper.showErroRedDialog(
                description: data2["message"].toString());
          }
          break;
        case 1:
          DialogHelper.showError("No Internet");
          break;
        default:
          DialogHelper.showError("Something went wrong");
          break;
      }
    });
  }

  void sendresetPassword() async {
    DialogHelper.showLoading();
    service.apiResetPassword(resetPasswordEmail.text).then((value) {
      print(value.statusCode);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.data);
          // response.add(LoginResponse.fromJson(value.data));
          print(data2["data"]);
          if (data2["status"].toString() == "1") {
            DialogHelper.showErroDialog(
                description: "Reset password sent successfully");
            PreferenceUtils().remove("lastPage");
            Get.offAndToNamed("/login");
          } else {
            DialogHelper.showErroRedDialog(
                description: "Email not resgistered with us");
          }
          break;
        case 1:
          DialogHelper.showError("No Internet");
          break;
        default:
          DialogHelper.showError("Something went wrong");
          break;
      }
    });
  }

  void submitOtp(customerid) async {
    DialogHelper.showLoading();
    // DialogHelper.showError("Invalid Credentails");
    service.apiVerifyOtpService(pinController.text, customerid).then((value) {
      print(value.statusCode);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.data);
          // response.add(LoginResponse.fromJson(value.data));
          print(data2["success"]);
          if (data2["status"].toString() == "1") {
            PreferenceUtils.saveUserCustomerId(
                data2["data"]["customerId"].toString());
            PreferenceUtils.setString(
                "name", data2["data"]["firstName"].toString());
            PreferenceUtils.setString(
                "email", data2["data"]["email"].toString());
            PreferenceUtils.setString(
                "mobile", data2["data"]["mobile"].toString());
            PreferenceUtils.saveUserToken(data2["data"]["token"].toString());
            PreferenceUtils().remove("lastPage");
            Get.offAllNamed("/");
          } else {
            DialogHelper.showError(data2["message"]);
          }

          break;
        case 1:
          DialogHelper.showError("No Internet");
          break;
        default:
          DialogHelper.showError("Something went wrong");
          break;
      }
    });
  }
}
