// lib/services/groq_service.dart
import 'dart:convert';
import 'package:flutter_with_ai/configs/api_config.dart';
import 'package:flutter_with_ai/models/story_req.dart';
import 'package:http/http.dart' as http;

class GroqService {
  Future<String> generateStory(StoryRequest request) async {
    final url = Uri.parse(ApiConfig.baseUrl);

    final body = jsonEncode({
      "model": ApiConfig.model,
      "messages": [
        {
          "role": "system",
          "content": "You are a historian storyteller. Provide engaging and historically accurate stories."
        },
        {
          "role": "user",
          "content": request.toPrompt(),
        }
      ],
      "max_tokens": _getMaxTokens(request.length),
      "temperature": 0.7
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${ApiConfig.apiKey}",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['choices'][0]['message']['content'] ?? "No story generated.";
    } else {
      throw Exception("Failed to generate story: ${response.statusCode} - ${response.body}");
    }
  }

  int _getMaxTokens(String length) {
    switch (length.toLowerCase()) {
      case "short":
        return 200;
      case "medium":
        return 500;
      case "full":
        return 1000;
      default:
        return 500;
    }
  }
}
