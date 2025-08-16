// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/story_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _topicController = TextEditingController();
  String _selectedLength = "medium";
  String _selectedTone = "engaging";

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StoryController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("AI History Storyteller")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _topicController,
              decoration: const InputDecoration(
                labelText: "Enter topic (e.g., World War 2)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedLength,
              items: const [
                DropdownMenuItem(value: "short", child: Text("Short")),
                DropdownMenuItem(value: "medium", child: Text("Medium")),
                DropdownMenuItem(value: "full", child: Text("Full")),
              ],
              onChanged: (val) => setState(() => _selectedLength = val!),
              decoration: const InputDecoration(
                labelText: "Select story length",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedTone,
              items: const [
                DropdownMenuItem(value: "engaging", child: Text("Engaging")),
                DropdownMenuItem(value: "serious", child: Text("Serious")),
                DropdownMenuItem(value: "casual", child: Text("Casual")),
              ],
              onChanged: (val) => setState(() => _selectedTone = val!),
              decoration: const InputDecoration(
                labelText: "Select tone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.isLoading
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      controller.generateStory(
                        _topicController.text.trim(),
                        _selectedLength,
                        _selectedTone,
                      );
                    },
              child: controller.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Generate Story"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.grey[50],
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SelectableText(
                      controller.storyResult.isEmpty
                          ? "Your story will appear here..."
                          : controller.storyResult,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
