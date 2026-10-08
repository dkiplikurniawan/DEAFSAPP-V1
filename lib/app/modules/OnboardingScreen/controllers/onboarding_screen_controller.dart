import 'package:get/get.dart';
import 'package:rive/rive.dart';

class OnboardingScreenController extends GetxController {
  var isSignInDialogShown = false.obs;
  var btnAnimationColtroller = Rxn<RiveAnimationController>();
  @override
  void onInit() {
    btnAnimationColtroller.value = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.onInit();
  }
}
