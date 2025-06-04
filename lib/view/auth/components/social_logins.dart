
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/app_urls.dart';
import '../../../util/config.dart';
import '../web_page.dart';

class SocialLogin extends StatelessWidget {
  final String assets;
  final String tittle;
  final String webview;
  const SocialLogin({
    super.key,
    required this.assets,
    required this.tittle,
    required this.webview,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(  borderRadius: BorderRadius.circular(15.r),
      onTap: () async {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => webView(
          //         url:
          //             "https://api.samba.events/FrontLogin/social-login?loginfrom=$webview&returnUrl=mobile", type: webview,
          //       )));
        if (kIsWeb) {
          // For web, open the URL in a new browser tab
          if (await canLaunchUrl(Uri.parse( AppUrls.baseUrl + "/FrontLogin/social-login?loginfrom=$webview&returnUrl=mobile"))) {
            await launchUrl(Uri.parse( AppUrls.baseUrl + "/FrontLogin/social-login?loginfrom=$webview&returnUrl=http://localhost:61799/#/social-login"), mode: LaunchMode.externalNonBrowserApplication);
          } else {
            debugPrint("Could not launch "+AppUrls.baseUrl +"/FrontLogin/social-login?loginfrom=$webview&returnUrl=mobile");
          }
        } else if (Platform.isAndroid || Platform.isIOS) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => webView(
                  url:
                      "https://apiloginv2.ticketer.sg/FrontLogin/social-login?loginfrom=$webview&returnUrl=mobile", type: webview,
                )));

      };
      },
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color:Get.theme.cardColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(211, 212, 226, 0.25),
              blurRadius: 2.0,
              spreadRadius: 2,
              offset: Offset(
                1,
                1,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: getProportionateScreenWidth(20),
              ),
              child: Image.asset(
                assets,
                height: 26,
                //color:webview=="apple"? Colors.white:null,
              ),
            ),
            Text(tittle, style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }
}
