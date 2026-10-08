import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_screen_controller.dart';
import '../controllers/speech_recognizer.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  const ChatScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Speech to Text"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 90),
        child: FloatingActionButton(
            child: !SpeechTextRecognizer.isListning()
                ? const Icon(Icons.mic)
                : const Icon(Icons.stop),
            onPressed: () {
              SpeechTextRecognizer.isListning()
                  ? SpeechTextRecognizer.stopListning
                  : controller.recognizedTexts();
            }),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Tekan Lalu Bicara, Maka teks Akan Merekam Sampai Kita Berhenti Bicara ${controller.isEnabled.value}"),
              const SizedBox(height: 15),
              Text(
                controller.recognizedText.value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
