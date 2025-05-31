import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme/apptheme.dart';

class DialogHelper {
  static void showError([String? message]) {
    Get.snackbar(
      "Error",
      duration: const Duration(milliseconds: 800),
      message!,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      icon: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }

  static void cupertinoDialog(VoidCallback onTap,
      {String? title = 'Are you sure you want to discard changes you made?'}) {
    Get.dialog(
      //  context: Get.context,//
      CupertinoAlertDialog(
        title: const Text('Discard Changes'),
        insetAnimationCurve: Curves.linear,
        insetAnimationDuration: const Duration(milliseconds: 500),
        content: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(title!),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Keep'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: onTap,
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  static void showLoading([String? message]) {
    Get.dialog(
      //  barrierColor: Color.fromARGB(255, 7, 41, 99).withOpacity(0.5),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(50)
            ),
            width: 80,
            height: 80,
            child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(50),
              child: Image.asset('assets/images/preloader.gif', fit: BoxFit.contain)),
          ),
        ],
      ),
    );
  }

  static void showErroDialog(
      {String title = 'Error', String? description = 'Try again later'}) {
    HapticFeedback.lightImpact();
    Fluttertoast.showToast(
        msg: description!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.primaryColor,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showErroRedDialog(
      {String title = 'Error', String? description = 'Try again later'}) {
    HapticFeedback.lightImpact();
    Fluttertoast.showToast(
        msg: description!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
