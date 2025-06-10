import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sambanew/models/AddOnModel.dart';
import 'package:sambanew/models/PromoCode.dart';
import 'package:sambanew/models/TicketerModel.dart';
import 'package:sambanew/view/event/bookings/payment_web.dart';

import '../components/dialogs.dart';
import '../models/CartModel.dart';
import '../models/PaymentGatewayModel.dart';
import '../service/event_repo.dart';
import '../service/shared_pref.dart';
import '../theme/apptheme.dart';
import '../util/app_urls.dart';
import '../view/event/bookings/add_ons.dart';
import '../view/event/bookings/booking_loaderpage.dart';

class TicketController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();

    getTickets();
    getAddOns();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (PreferenceUtils.isLoggedIn()) {
      name.text = PreferenceUtils.getString("name");
      email.text = PreferenceUtils.getString("email");
      cnemail.text = PreferenceUtils.getString("email");
      mobile.text = PreferenceUtils.getString("mobile") == "null"
          ? ""
          : PreferenceUtils.getString("mobile");
    }
  }

  final name = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final accessTextBox = TextEditingController();
  final cnemail = TextEditingController();
  final promoController = TextEditingController();

  bool knowEvant = true;
  bool sendMail = true;
  String error = "";
  String error1 = "";
  onChangeSendMail(value) {
    sendMail = value;
    update();
  }

  onChangKnowEvent(value) {
    knowEvant = value;
    update();
  }

  // onCheckheckout() {
  //   if (knowEvant == false) {
  //     error = "Required";
  //   } else if (sendMail == false) {
  //     error1 = "Required";
  //   } else {
  //     error = "";
  //     error1 = "";
  //   }
  //   update();
  // }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  List<TicketerModel> allTicket = List.empty(growable: true);
  List<TicketerModelData> ticketData = List.empty(growable: true);
  bool isLoaded = false;
  final service = EventService();
  applyAccessCode() async {
    isLoaded = false;
    update();
    service
        .apiGetTickets(Get.parameters["id"], accessTextBox.text,
            Get.parameters["scdueleid"].toString())
        .then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.data);
          if (decodedData["status"] == 1) {
            allTicket.clear();
            List<TicketerModelData> tempCart = ticketData;

            allTicket.add(TicketerModel.fromJson(decodedData));
            ticketData = allTicket.first.data!;
            if (tempCart.isNotEmpty) {
              for (var element in tempCart) {
                int index = ticketData.indexWhere((element) =>
                    element.eventTicketId == element.eventTicketId);
                ticketData[index].qty = int.parse(element.qty.toString());
              }
            }
          } else {
            accessTextBox.clear();
            DialogHelper.showErroRedDialog(
                description: "Access Code not valid");
          }

          update();
          break;

        default:
          isLoaded = true;
          DialogHelper.showErroRedDialog(description: "Access Code not valid");
          update();
          break;
      }
    });
  }

  void getTickets() async {
    allTicket.clear();

    service
        .apiGetTickets(
            Get.parameters["id"], "", Get.parameters["scdueleid"].toString())
        .then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          PreferenceUtils().remove("localSession");
          final decodedData = jsonDecode(value.data);
          allTicket.add(TicketerModel.fromJson(decodedData));
          ticketData = allTicket.first.data!;
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

  List<AddOnModel> addonData = List.empty(growable: true);
  bool isAddOnLoaded = false;

  void getAddOns() async {
    addonData.clear();

    service.apiGetEventAddon(Get.parameters["id"]).then((value) {
      switch (value.statusCode) {
        case 200:
          isAddOnLoaded = true;
          final decodedData = jsonDecode(value.data);
          addonData.add(AddOnModel.fromJson(decodedData));

          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isAddOnLoaded = true;
          update();
          break;
      }
    });
  }

  List<PromoCode> promoCodeList = [];
  bool isLoadedPromos = false;

  void getPromo(eventid) async {
    promoCodeList.clear();
    promoController.clear();
    service.apiGetPromoCodes(eventid).then((value) {
      switch (value.statusCode) {
        case 200:
          isLoadedPromos = true;
          final decodedData = jsonDecode(value.data);
          promoCodeList.add(PromoCode.fromJson(decodedData));
          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isLoadedPromos = true;
          update();
          break;
      }
    });
  }

  List<CartModel> cartItem = [];
  void getAllCart() async {
    service.apiGetCart().then((value) {
      print(value.statusCode);
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          cartItem.clear();
          cartItem.add(CartModel.fromJson(decodedData));

          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          break;
        default:
          cartItem.clear();
          update();
          break;
      }
    });
  }

  // checkTicketCart(ticketid) {
  //   if (cartItem.isEmpty) {
  //     return false;
  //   }
  //   if (cartItem.first.data!.any((element) {
  //     return element.eventTicketId == ticketid;
  //   })) {
  //     return true;
  //   }
  //   return false;
  // }

  // String getQuantity(ticketid) {
  //   int qty = 0;
  //   if (cartItem.isEmpty) {
  //     return "0";
  //   }
  //   cartItem.first.data!.forEach((element) {
  //     if (element.eventTicketId == ticketid || element.productId == ticketid) {
  //       qty = element.qty!;
  //     }
  //   });
  //   return qty.toString();
  // }

  // String getTempid(ticketid) {
  //   String tempCartId = "";
  //   if (cartItem.isEmpty) {
  //     return "0";
  //   }
  //   cartItem.first.data!.forEach((element) {
  //     if (element.eventTicketId == ticketid || element.productId == ticketid) {
  //       tempCartId = element.tempCartId.toString();
  //     }
  //   });
  //   return tempCartId.toString();
  // }
  double totalTempCost = 0;
  double totalAddOnCost = 0;
  double totalTickets = 0;
  onIncreaseTicketQty(eventid, ticketid, qty) {
    int index =
        ticketData.indexWhere((element) => element.eventTicketId == ticketid);
    ticketData[index].qty = int.parse(qty.toString()) + 1;
    // totalTempCost = ticketData.fold(
    //     0, (sum, item) => sum + double.parse(item.maxTicketPrice.toString()));
    totalTickets = ticketData.fold(
        0, (sum, item) => sum + double.parse(item.qty.toString()));
    totalTempCost = ticketData.fold(
        0,
        (sum, item) =>
            sum +
            double.parse(item.qty.toString()) *
                double.parse(item.ticketPrice.toString()));
    update();

    // addCart(eventid, int.parse(qty.toString()) + 1, ticketid);
  }

  onDecreaseTicketQty(eventid, ticketid, qty) {
    if (qty == 0) {
      return;
    }
    int index =
        ticketData.indexWhere((element) => element.eventTicketId == ticketid);
    ticketData[index].qty = int.parse(qty.toString()) - 1;
    totalTickets = ticketData.fold(
        0, (sum, item) => sum + double.parse(item.qty.toString()));
    totalTempCost = ticketData.fold(
        0,
        (sum, item) =>
            sum +
            double.parse(item.qty.toString()) *
                double.parse(item.ticketPrice.toString()));
    update();
  }

  onIncreaseAddOnQty(eventid, productId, qty) {
    int index = addonData.first.data!
        .indexWhere((element) => element.productId == productId);
    addonData.first.data![index].qty = int.parse(qty.toString()) + 1;
    totalAddOnCost = addonData.first.data!.fold(
        0,
        (sum, item) =>
            sum +
            double.parse(item.qty.toString()) *
                double.parse(item.price.toString()));
    update();

    // addCart(eventid, int.parse(qty.toString()) + 1, ticketid);
  }

  onDecreaseAddonQty(eventid, productId, qty) {
    if (qty == 0) {
      return;
    }
    int index = addonData.first.data!
        .indexWhere((element) => element.productId == productId);
    addonData.first.data![index].qty = int.parse(qty.toString()) - 1;
    totalAddOnCost = addonData.first.data!.fold(
        0,
        (sum, item) =>
            sum +
            double.parse(item.qty.toString()) *
                double.parse(item.price.toString()));

    update();
  }

  void addTicketCart() async {
    //cartItem.clear();
    DialogHelper.showLoading();
    int count = 0;
    bool isexit = false;
    for (var element in ticketData) {
      count++;
      if (element.qty! > 0) {
        print("first");
        final value = await service
            .apiCreateCartTicket(element.eventId, element.eventTicketId,
                element.qty, Get.parameters["scdueleid"].toString())
            .then((value) {
          switch (value.statusCode) {
            case 200:
              final decodedData = jsonDecode(value.data);
              print("second");
              if (decodedData["status"] == 0) {
                DialogHelper.showErroRedDialog(
                    description: decodedData["message"]);
                isexit = true;
                return;
              }
              // if (decodedData["data"][0]["localSessionId"] != null) {
              PreferenceUtils.setString(
                  "localSession", decodedData["data"][0]["localSessionId"]);
              print(
                  PreferenceUtils.getString("localSession") + count.toString());

              /// getAllCart(decodedData["data"][0]["localSessionId"]);
              // }

              // update();
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
      if (count == ticketData.length) {
        DialogHelper.hideLoading();
        getAllCart();

        if (!isexit) {
          if (addonData.isNotEmpty) {
            //  getDynamicJson();
            Get.to(
              const AddOnsPage(),
            );
          } else {
            // getDynamicJson();
            Get.toNamed(
              "/checkout/${Get.parameters["scdueleid"].toString()}",
            );
          }
        }
      }
    }
    print(count);
  }

  void addUpdatetProductCart(localsession) async {
    //cartItem.clear();

    DialogHelper.showLoading(
      "",
    );
    int count = 0;
    int checkFirst = 0;
    for (var element in addonData.first.data!) {
      count++;
      if (element.qty! > 0) {
        checkFirst++;
        final value = await service
            .apiUpdateCartProduct(element.eventId, element.productId,
                element.qty, checkFirst, localsession)
            .then((value) {
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

      DialogHelper.hideLoading();
      getAllCart();
      Get.toNamed(
        "/checkout/${Get.parameters["scdueleid"].toString()}",
      );
    }
    print(count);
  }

  void apiDeleteCart(localsession) async {
    //cartItem.clear();

    service.apiDeleteCart(localsession).then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          addTicketCart();
          // update();
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

  void apiEmptyCart(localsession) async {
    //cartItem.clear();

    service.apiDeleteCart(localsession).then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          PreferenceUtils().remove("localSession");
          // update();
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

  applied(code, eventid) {
    loadedOrderSummary = false;
    update();
    applyPromo(code, eventid, 0);
  }

  removeCoupon(eventid) {
    loadedOrderSummary = false;
    update();
    applyPromo("0", eventid, 0);
  }

  int totalitems = 0;
  String totalprice = "0";

  String tax = "0";
  String discount = "0";
  String tax1 = "0";
  String tax2 = "0";
  String totalAmt = "0";
  String pgCharges = "0";
  bool loadedOrderSummary = false;
  String applyCoupon = "";
  applyPromo(code, eventid, type) async {
    //cartItem.clear();

    service.apiApplyPromo(code, eventid).then((value) {
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          loadedOrderSummary = true;

          if (decodedData["status"] == 1) {
            promoController.clear();
            totalprice = decodedData["data"][0]["cost"].toString();
            totalAmt = decodedData["data"][0]["netTotal"].toString();
            tax = decodedData["data"][0]["conFee"].toString();
            if (code == "0") {
              applyCoupon = "";
              discount = "0";
            } else {
              applyCoupon = code;
              discount = decodedData["data"][0]["promoDiscount"].toString();
              DialogHelper.showErroDialog(description: "Promo applied");
              Get.back();
            }
            if (type == 1) {
              getDynamicJson();
            }
          } else {
            discount = "0";
            applyCoupon = "";
            DialogHelper.showErroRedDialog(
                description: "Promo code not applied");
            Get.back();
          }
          update();
          // update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          discount = "0";
          applyCoupon = "";
          loadedOrderSummary = true;
          update();
          break;
      }
    });
  }

  void checkout(eventPGFeeId,eventid, eventCode, total) async {
    //cartItem.clear();
    DialogHelper.showLoading(
      "",
    );
    service
        .apiCheckout(eventPGFeeId,eventid, eventCode, total, name.text, email.text,
            mobile.text, dynamicJsonCheckoutJson)
        .then((value) {
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          //boking no//paymentTag
          if (decodedData["data"][0]["paymentTag"] == 1) {
            Get.offAll(LoadingPaymentpgae(
                sno: "",
                netTotal: double.parse(total.toString()),
                tno: "",
                bkno: decodedData["data"][0]["bookingNo"]));
          }
          else {
            Fluttertoast.showToast(
                      msg: "Ticket Booked Successfully",
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.TOP,
                      textColor: Colors.white);
                  Get.offAllNamed("/");
          /* Get.to(webPaymentView(
                bkNo: decodedData["data"][0]["bookingNo"]?? "",
                nettotal: double.parse(total.toString()),
                url:
                AppUrls.baseUrl + "/Intouchgroup/Index/${decodedData["data"][0]["bookingNo"]}"));*/
          }
          break;
        case 401:
          Get.offAndToNamed("/login");
          break;
        case 1:
          break;
        default:
          DialogHelper.showErroDialog(description: "Something went wrong");
          break;
      }
    });
  }

  List<PaymentGatewayModel> paymentGatewayList = [];

  Future<void> getPaymentGateway(eventid) async {
    paymentGatewayList.clear();

    final value = await service.apiGetPaymentGateway(eventid);
    switch (value.statusCode) {
      case 200:
        loadedPaymentGateway = true;
        final decodedData = jsonDecode(value.data);
        paymentGatewayList.add(PaymentGatewayModel.fromJson(decodedData));

        if (paymentGatewayList.isNotEmpty) {
          await applyPaymentGateway(
            eventid,
            paymentGatewayList.first.data!.first.paymodes![0].eventPGFeeId,
          );
        }

        break;
      case 401:
        Get.offAndToNamed("/login");
        break;
      default:
        loadedPaymentGateway = true;
        break;
    }
    update();
  }



  bool loadedPaymentGateway = false;
  Future<void> applyPaymentGateway(eventid, eventPGFeeId) async {
    DialogHelper.showLoading("");
    try {
      final value = await service.apiPaymentGatewayCharges(eventid, eventPGFeeId);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.data);
          totalprice = decodedData["data"][0]["cost"].toString();
          totalAmt = decodedData["data"][0]["netTotal"].toString();
          tax1 = decodedData["data"][0]["pgFeeTax1"].toString();
          tax2 = decodedData["data"][0]["pgFeeTax2"].toString();
          pgCharges = decodedData["data"][0]["pgFee"].toString();
          break;
        case 401:
          Get.offAndToNamed("/login");
          break;
        default:
          break;
      }
    } finally {
      DialogHelper.hideLoading();
      update();
    }
  }


  static const int timerDuration = 15 * 60; // 15 minutes in seconds
  var timeRemaining = timerDuration.obs;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        timer.cancel();
        navigateToNextPage();
      }
    });
  }

  void navigateToNextPage() {
    // Navigate to the next page
    // Get.offNamed('/nextPage');\

    apiEmptyCart(PreferenceUtils.getString("localSession"));
    Get.dialog(
      barrierDismissible: false,
      transitionCurve: const FlippedCurve(Curves.bounceIn),
      transitionDuration: const Duration(milliseconds: 400),
      WillPopScope(
        onWillPop: () async {
          // Return false to prevent the dialog from closing when the back button is pressed
          return false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(children: [
                    Icon(
                      Icons.timer_off_outlined,
                      size: 26,
                      color: AppTheme.whiteBackgroundColor,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Cart Expired",
                      style: Get.theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Your cart is having abandonment issues.",
                      style: Get.theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    //Buttons
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed("/");
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        width: 120,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x8C333335).withOpacity(0.1),
                                offset: const Offset(1, 1),
                                blurRadius: 4.0,
                                spreadRadius: 2),
                          ],
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "BOOK NOW",
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              decoration: TextDecoration.none,
                              color: AppTheme.whiteBackgroundColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  final formKeys = <GlobalKey<FormState>>[];
  final formValues = <Map<String, dynamic>>[];
  var dynamicJsonCheckoutJson = "";
  List dynamicJsonList = [];
  bool isloadedDynamic = false;
  void getDynamicJson() async {
    formKeys.clear();
    formValues.clear();
    service.apiGetDynamicJson().then((value) {
      switch (value.statusCode) {
        case 200:
          isloadedDynamic = true;
          final decodedData = jsonDecode(value.data);
          dynamicJsonList = decodedData["data"];
          if (dynamicJsonList.isNotEmpty) {
            for (var i = 0; i < dynamicJsonList.length; i++) {
              List<dynamic> dynamicCheckout =
                  jsonDecode(dynamicJsonList[i]['dynamicCheckout']);
              formKeys.add(GlobalKey<FormState>());
              //   dynamicCheckout
              // .map((field) => buildFormField(field, formIndex));
              //  dynamicCheckout.forEach((field) {
              //formValues.add({dynamicJsonList[i]['dynamicCheckout']: ''});
              //  });
               formValues.add({});
              for (var field in dynamicCheckout) {
              
              formValues[i][field['label']] = getDefaultFieldValue(field['type']);
             //   formValues[i]['Required'] = field['Required'].toString();

            //  formValues[i].addAll({field['name']:getDefaultFieldValue(field['type']), 'Required' : field['Required'].toString()});
              }
              // formValues.add({});
            }
            tabController = TabController(
              initialIndex: 0,
              length: dynamicJsonList.length,
              vsync: this,
            );
          }
          // promoCodeList.add(PromoCode.fromJson(decodedData));
          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isloadedDynamic = true;
          update();
          break;
      }
    });
  }

  dynamic getDefaultFieldValue(String fieldType) {
    switch (fieldType) {
      case 'select': return ''; // For text or date fields, use an empty string
      case 'multiselect':
        return []; // For multiselect fields, return an empty list
      case 'checkbox':
        return false; // Default value for checkbox is false
      case 'text': return ''; // For text or date fields, use an empty string
      case 'date':
        return ''; // For text or date fields, use an empty string
      default:
        return ''; // Use null for any unsupported field types
    }
  }
}
//appply promo
//timmer
//access code
//close keyboard
//reset password