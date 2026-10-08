import 'package:dul/app/modules/BellScreen/controllers/bell_screen_controller.dart';
import 'package:dul/app/modules/ChatScreen/controllers/chat_screen_controller.dart';
import 'package:dul/app/modules/OnboardingScreen/controllers/onboarding_screen_controller.dart';
import 'package:dul/app/modules/Profile/controllers/profile_controller.dart';
import 'package:dul/app/modules/Search/controllers/search_controller.dart';
import 'package:dul/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final chatController = Get.put(ChatScreenController());
  final bellController = Get.put(BellScreenController());
  final homeController = Get.put(HomeController());
  final boardingController = Get.put(OnboardingScreenController());
  final profileController = Get.put(ProfileController());
  final sarchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      initialRoute: Routes.ONBOARDING_SCREEN,
      getPages: AppPages.routes,
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
