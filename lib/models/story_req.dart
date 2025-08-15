// lib/models/story_request.dart
class StoryRequest {
  final String topic;
  final String length;
  final String tone;

  StoryRequest({
    required this.topic,
    required this.length,
    required this.tone,
  });

  String toPrompt() {
    return """
Explain the historical topic: "$topic"
Length: $length
Tone: $tone
Make the story engaging, clear, and historically accurate.
If needed, break into sections with subtitles.
    """;
  }
}
