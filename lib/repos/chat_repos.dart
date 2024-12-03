import 'package:dio/dio.dart';

import '../models/chat_message_model.dart';

class GeminiRepo {
  static chatTextGenerationRepo(List<ChatMessageModel> previousMessage) async {
    Dio dio = Dio();
    final response = dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyD8vdVrEF0XOysW6SNaq1LdnQuypkJPfHY');
  }
}
