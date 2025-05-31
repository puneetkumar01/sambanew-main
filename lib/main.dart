import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sambanew/route/page_route.dart';
import 'package:sambanew/service/shared_pref.dart';
import 'package:sambanew/theme/apptheme.dart';
import 'package:sambanew/util/app_urls.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'langauge/translation.dart';
import 'util/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await Future.delayed(const Duration(milliseconds: 400));
  // // If the system can show an authorization request dialog
  // if (await AppTrackingTransparency.trackingAuthorizationStatus ==
  //     TrackingStatus.notDetermined) {
  //   // Show a custom explainer dialog before the system dialog
  //   // await showCustomTrackingDialog(Get.context!);
  //   // Wait for dialog popping animation
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   // Request system's tracking authorization dialog
  //   await AppTrackingTransparency.requestTrackingAuthorization();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // supportedLocales: [
            //   Locale('en'), // English
            //   Locale('es'), // Spanish
            //   const Locale('hi', 'IN'), // Hindi (India)
            //   Locale('es'), // Spanish
            // ],
            // locale: Get.deviceLocale,
            translations: AppTranslations(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en', 'US'),
            title: AppUrls.appName,
            getPages: AppPage.list,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            initialRoute: "/splash",

            // Handle deep linking
            // onGenerateRoute: (settings) {
            //   if (settings.name!.contains('/eventDetail')) {
            //     // Load data here if needed
            //     return GetPageRoute(
            //       settings: settings,
            //       page: () => EventDetails(),
            //     );
            //   }
            //  }
          );
        });
  }
}
