import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color whiteBackgroundColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color primaryColor = const Color.fromARGB(255, 2, 9, 89); //const Color.fromRGBO(59, 211, 169, 1);
  static Color lightprimaryColor =const Color.fromARGB(255, 179, 184, 243);// Color.fromARGB(255, 214, 174, 251); // Color(0xFF31D7A9).withOpacity(0.15);//Color(0xFF31D7A9).withOpacity(0.15);
  static Color lightTextColor = const Color.fromRGBO(116, 118, 136, 1);
  static Color darkTextColor = const Color.fromRGBO(18, 13, 38, 1);
  static Color ligthIconcolor = const Color.fromRGBO(202, 205, 212, 1);
  static Color border = const Color.fromRGBO(205, 205, 205, 1);
  static Color hintTextColor = const Color.fromRGBO(116, 118, 136, 1);
  static Color homePagecolor1 = const Color.fromRGBO(244, 244, 254, 1);
  static Color homePagecolor2 = const Color.fromRGBO(244, 241, 241, 1);
  static Color ticketBackground = const Color.fromRGBO(242, 242, 242, 1);
  static Color blueColor = const Color.fromRGBO(16, 28, 92, 1);
  static Color extraLigthtext = const Color.fromRGBO(92, 92, 92, 1);
  static Color veryLigthtext = const Color.fromRGBO(151, 151, 151, 1);
  static Color bordercolor = const Color(0XFFCACACA);
  static Color homePagecolor3 = const Color.fromRGBO(238, 236, 236, 1);
  static Color indicatorcolor = const Color.fromRGBO(152, 152, 152, 1);
  static Color lightHintTextColor = const Color.fromRGBO(166, 166, 166, 1);
  static Color newDarkColor = const Color.fromRGBO(12, 12, 12, 1);
  static Color purpleText = const Color(0xFF5040A1);
  static Color lightDarkText = const Color.fromRGBO(26, 29, 33, 1);
  
  AppTheme._();
  static final lightTheme = ThemeData(
    useMaterial3: false,
   // fontFamily: GoogleFonts.inter().fontFamily,
    brightness: Brightness.light,
    primaryColor: primaryColor,

    scaffoldBackgroundColor: homePagecolor1,
    appBarTheme: appBarTheme(),

    colorScheme: ThemeData().colorScheme.copyWith(
          secondary: primaryColor,
        ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor,
      selectionHandleColor: primaryColor,
    ),

    canvasColor: bordercolor,
    tabBarTheme: TabBarTheme(
      labelColor: darkTextColor,
      indicatorColor: primaryColor,
      indicator: UnderlineTabIndicator(
          // color for indicator (underline)
          borderSide: BorderSide(color: primaryColor, width: 2)),
      unselectedLabelColor: indicatorcolor,
      unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 16, color: indicatorcolor, fontWeight: FontWeight.w700),
      labelStyle: GoogleFonts.inter(
          fontSize: 16,
          color: darkTextColor,
          fontWeight: FontWeight.w700), // color for text
    ),
    // text theme2
    textTheme: TextTheme(
        displaySmall: hintText,
        displayLarge: displayLarge,
        headlineLarge: headingText,
        headlineMedium: headingsmallText,
        headlineSmall: smalltext3,
        displayMedium: smalltext2,
        bodyMedium: bodytext,
        bodyLarge: bodyLarge,
        labelSmall: labelsmall,
        bodySmall: smallText),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),

    visualDensity: VisualDensity.adaptivePlatformDensity,
    //   appBarTheme: AppBarTheme(backgroundColor: lightPrimaryColor),
  );
  static final TextStyle hintText = GoogleFonts.inter(
    color: hintTextColor,
    fontSize: 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle displayLarge = GoogleFonts.inter(
    color: hintTextColor,
    fontSize: 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle labelsmall = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 10,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle smallText = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle headingText = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 24,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle headingsmallText = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 20,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle bodytext = GoogleFonts.inter(
    color: extraLigthtext,
    fontSize: 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle bodyLarge = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle smalltext2 = GoogleFonts.inter(
    color: veryLigthtext,
    fontSize: 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle smalltext3 = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );

  static final darktheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.inter().fontFamily,
    shadowColor: hintTextColor,
    hoverColor: const Color.fromRGBO(56, 67, 79, 1),
    datePickerTheme: const DatePickerThemeData(
        elevation: 0,
        backgroundColor: Color.fromRGBO(26, 29, 33, 1),
        headerBackgroundColor: Color.fromRGBO(26, 29, 33, 1)),
    tabBarTheme: TabBarTheme(
      labelColor: whiteBackgroundColor,
      indicatorColor: primaryColor,
      unselectedLabelColor: whiteBackgroundColor,
      unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          color: whiteBackgroundColor,
          fontWeight: FontWeight.w500),
      labelStyle: GoogleFonts.inter(
          fontSize: 14,
          color: whiteBackgroundColor,
          fontWeight: FontWeight.w500), // color for text
    ),
    primaryColor: whiteBackgroundColor,
    appBarTheme: appBarDarkTheme(),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color.fromRGBO(26, 29, 33, 1),
    ),
    iconTheme: IconThemeData(color: whiteBackgroundColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    scaffoldBackgroundColor:const Color.fromRGBO(20, 20, 20, 1),// lightDa Color.fromRGBO(47, 47, 47, 1),// lightDarkText,,
    // backgroundColor: darkTextColor,
    indicatorColor: lightDarkText,
    cardColor: newDarkColor,// lightDarkText,
    canvasColor: AppTheme.whiteBackgroundColor,
    textTheme: TextTheme(
      headlineMedium: headingsmallText.copyWith(color: whiteBackgroundColor),
      headlineLarge: headingText.copyWith(color: whiteBackgroundColor),
      headlineSmall: smalltext3.copyWith(color: whiteBackgroundColor),
      displayLarge: darktext14Px,
      displaySmall: ligthHintColor,
      bodySmall: smallText.copyWith(color: whiteBackgroundColor),
      labelSmall: labelsmall.copyWith(color: lightHintTextColor),
      displayMedium: ligthDisplayMedium,
      bodyMedium: bodytext.copyWith(color: lightHintTextColor),
    ),
  );
  static final TextStyle darktext14Px = GoogleFonts.inter(
    color: whiteBackgroundColor,
    fontSize: 14,
    letterSpacing: 0,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle ligthHintColor =
      hintText.copyWith(color: lightHintTextColor);
  static final TextStyle ligthDisplayMedium =
      smallText.copyWith(color: lightHintTextColor);
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: AppTheme.darkTextColor),
    titleTextStyle: GoogleFonts.inter(
        fontSize: 16,
        color: AppTheme.darkTextColor,
        fontWeight: FontWeight.w500),
  );
}

AppBarTheme appBarDarkTheme() {
  return AppBarTheme(
    //   surfaceTintColor: Colors.transparent,
    //color: Colors.white,
    elevation: 0,

    backgroundColor:const Color.fromRGBO(20, 20, 20, 1),
    //  scrolledUnderElevation: 0,
    //  brightness: Brightness.dark,
    iconTheme: IconThemeData(color: AppTheme.whiteBackgroundColor),
    titleTextStyle: GoogleFonts.inter(
        fontSize: 16,
        color: AppTheme.whiteBackgroundColor,
        height: 0,
        fontWeight: FontWeight.w500),
  );
}
