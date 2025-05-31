import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../service/auth_repo.dart';
import '../../service/shared_pref.dart';

class webView extends StatefulWidget {
  const webView({
    super.key,
    required this.url,
    required this.type,
  });
  final String url;
  final String type;
  @override
  State<webView> createState() => _MainPageState();
}

class _MainPageState extends State<webView> {
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
            if (request.url.contains("status=0")) {
              print("FAILED${request.url}");
              //  Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //           builder: (BuildContext context) => TransactionStatus(type: 2,)),

              //       );
              // flutter: launchaahttps://www.codingcrown.com/?razorpay_payment_id=pay_N5Ahv1uI5SB3S1&razorpay_payment_link_id=plink_N5Ag0kOnHScGHZ&razorpay_payment_link_reference_id=&razorpay_payment_link_status=paid&razorpay_signature=0cbe8ea4b70489ab4a2829f8a90b26858b198aaf66455e533a06f0e51ed1692d
              return NavigationDecision.prevent;
            } else if (request.url.contains("status=1")) {
              print("Success${request.url}");
              var uri = Uri.parse(request.url);
              String? email = uri.queryParameters["email"];
              String? lc = uri.queryParameters["lc"];

              print(email);
              // if (widget.type == 2) {
              final service = AuthService();

              service
                  .apiVerifySocialLogins(lc, email, widget.type)
                  .then((value) {
                if (value.statusCode == 200) {
                  var data2 = jsonDecode(value.data);
                  // response.add(LoginResponse.fromJson(value.data));
                  print(data2["data"]);

                  PreferenceUtils.saveUserCustomerId(
                      data2["data"]["customerId"].toString());
                  PreferenceUtils.setString(
                      "name", data2["data"]["firstName"].toString());
                  PreferenceUtils.setString(
                      "email", data2["data"]["email"].toString());
                  PreferenceUtils.setString(
                      "mobile", data2["data"]["mobile"].toString());
                  PreferenceUtils.saveUserToken(
                      data2["data"]["token"].toString());
                  if (PreferenceUtils.getString("lastPage") == "eventdetails") {
                    PreferenceUtils().remove("lastPage");
                    //  Get.back();
                    //  Get.back();
                      Get.offNamedUntil('/checkout',arguments: {"data":"login"}, (route) => route.settings.name=="/AddOnsPage");
        
              //      // Navigator.of(context).removeRouteByName('/login');
              //     //   Navigator.of(context).removeRouteByName('/webview');
                  
              //   Navigator.removeRoute(
              // context, MaterialPageRoute(builder: (context) => Login()));
              //  Navigator.removeRoute(
              // context, MaterialPageRoute(builder: (context) => ()));
                  
                  } else {
                    Get.offAllNamed("/");
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Something went wrong",
                      backgroundColor: Colors.red,
                      gravity: ToastGravity.TOP,
                      textColor: Colors.white);
                }
              });
              // }

              return NavigationDecision.prevent;
            } else if (request.url.startsWith('tel:') ||
                request.url.startsWith('whatsapp:') ||
                request.url.startsWith('fb:') ||
                request.url.startsWith('tg:')) {
              if (await canLaunch(request.url)) {
                await launch(request.url);
              }
              return NavigationDecision.prevent;
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
        if (await _controller.canGoBack()) {
          _controller.goBack();

          return false;
        }
        // Stay App
        else {
          return true;
        }

        // if (await controller.canGoBack()) {
        //   print("onwill goback");
        //   controller.goBack();
        //   return Future.value(true);
        // } else {
        //   print("onwill not");

        //   return Future.value(false);
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.3,
          title: Text(widget.type == "google"
              ? "Login with Google"
              : widget.type == "facebook"
                  ? "Login with Facebook"
                  : "Login with Apple"),
          leading: GestureDetector(
              onTap: () {
                Future.delayed(const Duration(milliseconds: 400), () {
                  Get.offNamed("/login");
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
