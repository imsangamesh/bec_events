import 'package:demo_bec/core/themes/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:demo_bec/core/constants/pref_keys.dart';

class ThemeController extends GetxController {
  //
  final _box = GetStorage();
  final primary = MyColors.pink.obs;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  bool get _isDarkMode => _box.read(PrefKeys.isDarkMode) ?? false;

  configureTheme() {
    if (_isDarkMode) {
      primary(MyColors.pink);
    } else {
      primary(MyColors.lightPurple);
    }
  }

  toggleThemeMode() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      _box.write(PrefKeys.isDarkMode, false);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      _box.write(PrefKeys.isDarkMode, true);
    }
  }
}
