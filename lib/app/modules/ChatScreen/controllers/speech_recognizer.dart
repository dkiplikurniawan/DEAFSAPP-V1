import 'package:speech_to_text/speech_to_text.dart';
// ignore: unused_import
import '../views/chat_screen_view.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechTextRecognizer {
  static SpeechToText speechToText = SpeechToText();

  static initialize() async {
    bool status = await speechToText.initialize();
    // ignore: avoid_print
    print(status);
    return status;
  }

  static startListning(Function(SpeechRecognitionResult) recogFn) async {
    try {
      await speechToText.listen(
          listenMode: ListenMode.dictation,
          onResult: recogFn,
          listenFor: const Duration(seconds: 90));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static void stopListning() async {
    await speechToText.stop();
  }

  static bool isListning() {
    return speechToText.isListening;
  }
}
