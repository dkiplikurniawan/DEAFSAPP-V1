import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:get/get.dart';
import './speech_recognizer.dart';

class ChatScreenController extends GetxController {
  var recognizedText = "Recognize text is".obs;
  var isEnabled = false.obs;

  checkSpeechAvailability() async {
    isEnabled.value = await SpeechTextRecognizer.initialize();
  }

  recognizedTexts() async {
    await SpeechTextRecognizer.startListning(speechRecogListner);
  }

  void speechRecogListner(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    recognizedText.value = result.recognizedWords;
  }

  @override
  void onInit() {
    checkSpeechAvailability();
    super.onInit();
  }
}
