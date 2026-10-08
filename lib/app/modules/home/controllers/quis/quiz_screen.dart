import 'dart:async';

import 'package:dul/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: unused_import
import 'api_services.dart';
import 'const/colors.dart';
// ignore: unused_import
import 'const/images.dart';
import 'const/text_style.dart';

class QuizScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [blue, darkBlue],
        )),
        child: FutureBuilder(
          future: controller.quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data["results"];

              if (controller.isLoaded.value == false) {
                controller.optionsList.value =
                    data[controller.currentQuestionIndex.value]
                        ["incorrect_answers"];
                controller.optionsList.add(
                    data[controller.currentQuestionIndex.value]
                        ["correct_answer"]);
                controller.optionsList.shuffle();
                controller.isLoaded.value = true;
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: lightgrey, width: 2),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                CupertinoIcons.xmark_circle,
                                color: Colors.white,
                                size: 28,
                              )),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            normalText(
                                color: Colors.white,
                                size: 24,
                                text: "${controller.seconds}"),
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                value: controller.seconds / 60,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: lightgrey, width: 2),
                          ),
                          child: TextButton.icon(
                              onPressed: null,
                              icon: const Icon(CupertinoIcons.heart_fill,
                                  color: Colors.white, size: 18),
                              label: normalText(
                                  color: Colors.white, size: 14, text: "Like")),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Image.asset("assets/quis/ideas.png", width: 200),
                    const SizedBox(height: 20),
                    Obx(
                      () => Align(
                          alignment: Alignment.centerLeft,
                          child: normalText(
                              color: lightgrey,
                              size: 18,
                              text:
                                  "Question ${controller.currentQuestionIndex.value + 1} of ${data.length}")),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => normalText(
                          color: Colors.white,
                          size: 20,
                          text: data[controller.currentQuestionIndex.value]
                              ["question"]),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.optionsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var answer =
                              data[controller.currentQuestionIndex.value]
                                  ["correct_answer"];

                          return GestureDetector(
                            onTap: () {
                              if (answer.toString() ==
                                  controller.optionsList[index].toString()) {
                                controller.optionsColor[index] = Colors.green;
                                controller.points = controller.points + 10;
                              } else {
                                controller.optionsColor[index] = Colors.red;
                              }

                              if (controller.currentQuestionIndex.value <
                                  data.length - 1) {
                                Future.delayed(const Duration(seconds: 1), () {
                                  controller.gotoNextQuestion();
                                });
                              } else {
                                controller.timer!.cancel();
                                //here you can do whatever you want with the results
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: size.width - 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: controller.optionsColor[index],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: headingText(
                                color: blue,
                                size: 18,
                                text: controller.optionsList[index].toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      )),
    );
  }
}
