import 'dart:developer';

import 'package:demo_bec/modules/auth/auth_controller.dart';
import 'package:demo_bec/modules/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/constants/my_constants.dart';
import 'core/themes/my_themes.dart';
import 'core/themes/theme_controller.dart';
import 'modules/auth/signin_screen.dart';

bool _initialURILinkHandled = false;

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDis3DBR_V4PXoakbZLQqFBxmntDkP0EqM",
      appId: "1:321357522673:android:6c75e68bd6f686fffa2b50",
      messagingSenderId: "321357522673",
      projectId: "becevents-b2056",
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  final themeCntrl = Get.put(ThemeController());

  themeCntrl.configureTheme();

  final authController = Get.put(AuthController());

  authController.checkForAdminAndUpdate(false);

  if (authController.isUserPresent && auth.currentUser != null) {
    log('======================== USER ID : ${auth.currentUser!.uid}');
    runApp(MyApp(HomeScreen()));
    return;
  }

  runApp(MyApp(SigninScreen()));
}

final globalThemeContrl = Get.find<ThemeController>();

class MyApp extends StatelessWidget {
  const MyApp(this.screen, {super.key});

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: globalThemeContrl.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: screen,
    );
  }
}
