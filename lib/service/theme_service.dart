import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sambanew/service/shared_pref.dart';

class ThemeService {
  // final _box = GetStorage();
  final _key = 'isTheme';

  ThemeMode get theme =>
      loadThemeFromBox() == "light" ? ThemeMode.light : ThemeMode.dark;

  String loadThemeFromBox() =>
      PreferenceUtils.getString(_key) == ""||PreferenceUtils.getString(_key) == "dark" ? "dark" : "light";
  //_saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void switchTheme(value) async {
    await PreferenceUtils.setString(_key, value);
    // Get.changeTheme(PreferenceUtils.getBool(_key));
    // ? AppTheme.lightTheme
    //    : AppTheme.darktheme);
    Get.changeThemeMode(PreferenceUtils.getString(_key) == "light"
        ? ThemeMode.light
        : ThemeMode.dark);

    print(PreferenceUtils.getString(_key));

    //   _box.write(_key, true);

    //_saveThemeToBox(!_loadThemeFromBox());
  }
}
