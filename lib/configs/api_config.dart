// lib/config/api_config.dart
class ApiConfig {
  static const String baseUrl = "https://api.groq.com/openai/v1/chat/completions";

  // ⚠️ Use your actual Groq API Key here during development
  // For production, load from secure storage or environment variables
  static const String apiKey = "";

  // Correct model name based on Groq's naming
  static const String model = "openai/gpt-oss-20b";
}
