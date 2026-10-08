import 'package:get/get.dart';

import '../controllers/bell_screen_controller.dart';

class BellScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BellScreenController>(
      () => BellScreenController(),
    );
  }
}
