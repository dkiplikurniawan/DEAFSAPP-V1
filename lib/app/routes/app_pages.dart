import 'package:get/get.dart';

import '../modules/BellScreen/bindings/bell_screen_binding.dart';
import '../modules/BellScreen/views/bell_screen_view.dart';
import '../modules/ChatScreen/bindings/chat_screen_binding.dart';
import '../modules/ChatScreen/views/chat_screen_view.dart';
import '../modules/OnboardingScreen/bindings/onboarding_screen_binding.dart';
import '../modules/OnboardingScreen/views/onboarding_screen_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/Search/bindings/search_binding.dart';
import '../modules/Search/views/search_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_SCREEN,
      page: () => OnboardingScreenView(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: _Paths.BELL_SCREEN,
      page: () => BellScreenView(),
      binding: BellScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
