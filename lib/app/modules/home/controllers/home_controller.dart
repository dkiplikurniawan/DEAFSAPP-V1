import 'dart:async';

import 'package:dul/app/modules/home/controllers/quis/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var seconds = 60.obs;
  Timer? timer;
  late Future quiz;

  int points = 0;

  var isLoaded = false.obs;

  var optionsList = [].obs;

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds.value--;
      } else {
        gotoNextQuestion();
      }
    });
  }

  gotoNextQuestion() {
    isLoaded.value = false;
    currentQuestionIndex++;
    resetColors();
    timer!.cancel();
    seconds.value = 60;
    startTimer();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  @override
  void onInit() {
    quiz = getQuiz();
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
