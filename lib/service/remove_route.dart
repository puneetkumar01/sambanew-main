import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension NavigatorStateExtension on NavigatorState {
  void removeRouteByName(String routeName) {
    List<Route<dynamic>> newStack = [];
    bool found = false;

    // Pop all routes until we find the one we want to remove
    popUntil((route) {
      if (Get.currentRoute == routeName) {
        found = true;
        return true;
      } else {
        newStack.add(route);
        return false;
      }
    });

    // Push back all other routes
    newStack.forEach(pushRoute);
  }

  void pushRoute(Route<dynamic> route) {
    push(route);
  }
}
