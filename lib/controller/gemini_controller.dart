import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/chat_message_model.dart';

class GeminiController extends GetxController {
  TextEditingController chatController = TextEditingController();
  static const apiKey = "AIzaSyD8vdVrEF0XOysW6SNaq1LdnQuypkJPfHY";
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
  final RxList<ModelMessage> prompt = <ModelMessage>[].obs;

  Future<void> sentMessage() async {
    final message = chatController.text;
    chatController.clear();
    prompt.add(
      ModelMessage(
        isPrompt: true,
        message: message,
        time: DateTime.now(),
      ),
    );
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    prompt.add(
      ModelMessage(
        isPrompt: false,
        message: response.text ?? "",
        time: DateTime.now(),
      ),
    );
  }
}
