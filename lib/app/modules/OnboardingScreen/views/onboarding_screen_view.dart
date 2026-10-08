import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rive/rive.dart';
import '../controllers/animated_btn.dart';
import '../controllers/custom_sign_in_dialog.dart';
import '../controllers/onboarding_screen_controller.dart';

class OnboardingScreenView extends GetView<OnboardingScreenController> {
  const OnboardingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            ),
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              top: controller.isSignInDialogShown.value ? -50 : 0,
              duration: const Duration(milliseconds: 240),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: 260,
                        child: Column(
                          children: const [
                            Text(
                              "Learn design & code",
                              style: TextStyle(
                                fontSize: 60,
                                fontFamily: "Poppins",
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 2),
                      AnimatedBtn(
                        btnAnimationColtroller:
                            controller.btnAnimationColtroller.value!,
                        press: () {
                          controller.btnAnimationColtroller.value!.isActive =
                              true;
                          Future.delayed(
                            const Duration(milliseconds: 800),
                            () {
                              controller.isSignInDialogShown.value = true;

                              customSigninDialog(
                                context,
                                onCLosed: (_) {
                                  controller.isSignInDialogShown.value = false;
                                },
                              );
                            },
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
