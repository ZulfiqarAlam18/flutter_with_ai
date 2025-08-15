// lib/controllers/story_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_with_ai/models/story_req.dart';
import 'package:flutter_with_ai/services/services.dart';

class StoryController extends ChangeNotifier {
  final _service = GroqService();
  bool isLoading = false;
  String storyResult = "";

  Future<void> generateStory(String topic, String length, String tone) async {
    isLoading = true;
    storyResult = "";
    notifyListeners();

    try {
      final request = StoryRequest(topic: topic, length: length, tone: tone);
      storyResult = await _service.generateStory(request);
    } catch (e) {
      storyResult = "Error: $e";
    }

    isLoading = false;
    notifyListeners();
  }
}
