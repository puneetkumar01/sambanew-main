import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sambanew/theme/apptheme.dart';

class ExpandedText extends StatelessWidget {
  String text;
  var ontap;
  List<dynamic>? uuid;
  TextStyle style;
  int length;

  ExpandedText({
    super.key,
    this.uuid,
    required this.text,
    required this.style,
    this.length = 120,
    this.ontap,
  });

  String? FirstHalf;
  String? SecondHalf;
  bool showAll = true;

  ValueNotifier<bool> expanded = ValueNotifier(false);
  List<String> getAllHashtags(String text) {
    // final regexp = RegExp(r'\#[a-zA-Z0-9]+\b()');
    // RegExp regex = RegExp(r'#(\S+)');
    RegExp regexp = RegExp(r'#(\S+)');
    List<String> hashtags = [];

    regexp.allMatches(text).forEach((element) {
      if (element.group(0) != null) {
        hashtags.add(element.group(0).toString());
      }
    });

    return hashtags;
  }

  List<String> getAllMentions(String text) {
    //final regexp = RegExp(r'\@[a-zA-Z0-9]+\b()');
    //RegExp regexp = RegExp(r'@(\S+)');
    RegExp regex = RegExp(r'@(\S+)');
    List<String> mentions = [];

    regex.allMatches(text).forEach((element) {
      if (element.group(0) != null) {
        mentions.add(element.group(0).toString());
      }
    });

    return mentions;
  }

  RichText buildHighlightedText(context, String text) {
    // clean the text
    text = cleanText(text);

    List<String> validMentions = ["@mention1", "@mention2"];

    List<String> hashtags = getAllHashtags(text);
    List<String> mentions = getAllMentions(text);

    text = showAll ? FirstHalf.toString() : text.toString();
    List<TextSpan> textSpans = [];
//RegExp(r"\s")
    // text.split(RegExp(r'\s+')).forEach((value) {
    text.split(' ').forEach((value) {
//      print(value);

      // if (hashtags.contains(value)) {
      //   textSpans.add(TextSpan(
      //     text: '$value ',
      //     recognizer: TapGestureRecognizer()
      //       ..onTap = () {
      //         Get.toNamed(Routes.Search,
      //             arguments: {'text': value.replaceAll("#", "")});
      //       },
      //     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      //   ));
      //   //&& validMentions.contains(value)) {
      // } else if (mentions.contains(value)) {
      //   textSpans.add(TextSpan(
      //     text: '$value ',
      //     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      //     recognizer: TapGestureRecognizer()
      //       ..onTap = () {
      //         if (uuid == null) {
      //           return;
      //         }
      //         if (uuid!.isNotEmpty) {
      //           final tag = uuid!
      //               .where((element) =>
      //                   element["MID"] == value.replaceAll("@", ""))
      //               .toList();
      //           if (tag.isNotEmpty) {
      //             //  print(tag[0]["uuid"]);
      //             Get.to(ProfilePage(tag[0]["uuid"]),
      //                 fullscreenDialog: true,
      //                 duration: Duration(milliseconds: 500));
      //           }
      //         }
      //       },
      //   ));
      // } else {
      textSpans.add(TextSpan(
        text: '$value ',
        // text: utf8.decode(value.toString().codeUnits),
        style: style,
      ));

      /// }
    });
    if (SecondHalf != "") {
      textSpans.add(TextSpan(
        text: showAll ? ' ..see more' : ' ..see less',
        style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 13, color: AppTheme.primaryColor),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            showAll = !showAll;
            expanded.value = !expanded.value;
          },
      ));
    }

    return RichText(
      text: TextSpan(children: textSpans, style: style), textScaler: TextScaler.linear(MediaQuery.of(context).textScaleFactor),
    );
  }

  String cleanText(String text) {
    text = text.replaceAllMapped(
        RegExp("#"), (Match m) => "${m[0]?.split('').join(" ")}");

    text = text.replaceAllMapped(
        RegExp("@"), (Match m) => "${m[0]?.split('').join(" ")}");

    return text;
  }

  String fixUTF8String(String utf8String) {
    // Example: remove the incomplete sequence at offset 7
    return utf8String.substring(0, 6) + utf8String.substring(8);
  }

  @override
  Widget build(BuildContext context) {
    if (text.length > length) {
      FirstHalf = text.substring(0, length);
      SecondHalf == text.substring(length, text.length);
    } else {
      FirstHalf = text;
      SecondHalf = "";
    }

    return ValueListenableBuilder(
        valueListenable: expanded,
        builder: (context, values, _) {
          return buildHighlightedText(context, text);
        });
  }
}
