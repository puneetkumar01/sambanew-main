
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sambanew/view/event/bookings/booking_loaderpage.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../components/dialogs.dart';
import 'booking_failed.dart';

class webPaymentView extends StatefulWidget {
  const webPaymentView({
    super.key,
    required this.url,
    required this.nettotal, required this.bkNo,
  });
  final String url;final String bkNo;
  final double nettotal;
  @override
  State<webPaymentView> createState() => _MainPageState();
}

class _MainPageState extends State<webPaymentView> {
  late WebViewController _controller; // Declare the WebViewController
  bool _isLoading = true; // To track loading state

  bool showFloat = false;
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    loadurl();
  }

  List paymentDetils = [];

  loadurl() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
      WebKitWebViewController(params)
          .setAllowsBackForwardNavigationGestures(true);
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..enableZoom(true)
      ..setUserAgent("random")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const LoadingPage();
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                // if (widget.url.toString() == widget.url.toString()) {
                _isLoading = true; // Show loader when page starts loading
                // }
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false; // Hide loader when page finishes loading
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) async {
            print("launchaa${request.url}");
            if (request.url.contains("errorCode=200")) {
              var uri = Uri.parse(request.url);
              print("Success payment${request.url}");
              String? tno = uri.queryParameters["num_transaction_from_gu"];
              String? sno = uri.queryParameters["num_command"];
              Get.offAll(LoadingPaymentpgae(
                sno: sno!,
                netTotal: widget.nettotal,
                tno: tno!, bkno: widget.bkNo
              ));
//launchaahttps://samba.events/Intouchgroup/ResponseUrl?num_transaction_from_gu=1723485869774&num_command=sid20240812180419984055&amount=50&errorCode=202#payment-choice-anchor

              // final service = EventService();

              // service.apiConfirmPayment(sno, widget.nettotal, tno).then((value) {
              //   if (value.statusCode == 200) {
              //     var data2 = jsonDecode(value.data);
              //     // response.add(LoginResponse.fromJson(value.data));
              //     print(data2["data"]);
              //     Fluttertoast.showToast(
              //         msg: "Ticket Booked Successfully",
              //         backgroundColor: Colors.green,
              //         gravity: ToastGravity.TOP,
              //         textColor: Colors.white);
              //     Get.offAllNamed("/");
              //   } else {
              //     Fluttertoast.showToast(
              //         msg: "Something went wrong",
              //         backgroundColor: Colors.red,
              //         gravity: ToastGravity.TOP,
              //         textColor: Colors.white);
              //   }
              // });

              return NavigationDecision.prevent;
            } else if (!request.url.contains("errorCode=200") &&
                request.url.contains(
                    "Intouchgroup/Response?num_transaction_from_gu=")) {
              print("Failed${request.url}");
                Get.offAll(const BookingFailed());
              return NavigationDecision.navigate;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url.toString()));
    _controller = controller;
  }

  DateTime? lastBackPressedTime;

  @override
  Widget build(BuildContext context) {
    return buildWillPopScope();
  }

  int index = 0;
  bool onWillPop = false;
  late DateTime currentBackPressTime;
  buildWillPopScope() {
    return WillPopScope(
      onWillPop: () async {
        DialogHelper.cupertinoDialog(
            title: "Are you sure you want to cancel booking", () {
               Future.delayed(const Duration(milliseconds: 800), () {
                Get.deleteAll();
          Get.offNamedUntil("/" , (route) => false);
        });   });

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.3,
          title: const Text("Payment Gateway"),
          leading: GestureDetector(
              onTap: () {    Get.deleteAll();
                DialogHelper.cupertinoDialog(
                    title: "Are you sure you want to cancel booking", () {
                       Future.delayed(const Duration(milliseconds: 800), () {
                  Get.offNamed("/");
                });
                 
                });
              },
              child: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Stack(
          children: [
            SafeArea(
                child: WebViewWidget(
              controller: _controller,
            )),
            if (_isLoading)
              const Center(
                child: LoadingPage(), // Loader widget
              ),
          ],
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
  }
}
