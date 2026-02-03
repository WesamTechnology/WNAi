import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class AIService {
  // AI Horde anonymous API key (free, no registration required)
  static const String _aiHordeKey = "0000000000";
  static const String _aiHordeBaseUrl = "https://stablehorde.net/api/v2";

  /// Sends a prompt to the Pollinations AI API with the specified model.
  /// Returns the generated text response.
  static Future<String> generateResponse(String prompt, String modelId) async {
    try {
      final uri = Uri.parse(
        'https://text.pollinations.ai/${Uri.encodeComponent(prompt)}?model=$modelId',
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to AI service: $e');
    }
  }

  /// Generate image using AI Horde (free, community-powered)
  /// Returns the image URL when generation is complete
  static Future<String> generateImageWithAIHorde(String prompt) async {
    try {
      // Step 1: Submit the generation request
      final requestBody = jsonEncode({
        "prompt": prompt,
        "params": {
          "sampler_name": "k_euler",
          "cfg_scale": 7.5,
          "width": 512,
          "height": 512,
          "steps": 30,
        },
        "nsfw": false,
        "censor_nsfw": true,
        "models": ["stable_diffusion"],
        "r2": true,
        "shared": false,
      });

      final submitResponse = await http
          .post(
            Uri.parse("$_aiHordeBaseUrl/generate/async"),
            headers: {
              "Content-Type": "application/json",
              "apikey": _aiHordeKey,
              "Client-Agent": "NewsApp:1.0:Flutter",
            },
            body: requestBody,
          )
          .timeout(const Duration(seconds: 30));

      if (submitResponse.statusCode != 202) {
        throw Exception(
          "Failed to submit request: ${submitResponse.statusCode}",
        );
      }

      final submitData = jsonDecode(submitResponse.body);
      final String requestId = submitData["id"];

      // Step 2: Poll for completion
      String? imageUrl;
      int attempts = 0;
      const maxAttempts = 60; // Max 2 minutes

      while (imageUrl == null && attempts < maxAttempts) {
        await Future.delayed(const Duration(seconds: 2));
        attempts++;

        final statusResponse = await http
            .get(
              Uri.parse("$_aiHordeBaseUrl/generate/status/$requestId"),
              headers: {"Client-Agent": "NewsApp:1.0:Flutter"},
            )
            .timeout(const Duration(seconds: 10));

        if (statusResponse.statusCode == 200) {
          final statusData = jsonDecode(statusResponse.body);

          if (statusData["done"] == true &&
              statusData["generations"] != null &&
              (statusData["generations"] as List).isNotEmpty) {
            imageUrl = statusData["generations"][0]["img"];
            break;
          }

          // Check if request failed
          if (statusData["faulted"] == true) {
            throw Exception("Image generation failed on server");
          }
        }
      }

      if (imageUrl == null) {
        throw Exception("Timeout waiting for image generation");
      }

      return imageUrl;
    } catch (e) {
      print("AI Horde error: $e");
      // Fallback to Pollinations simple URL
      return generateImageUrlSimple(prompt);
    }
  }

  /// Simple Pollinations URL (fallback)
  static String generateImageUrlSimple(String prompt) {
    final seed = Random().nextInt(1000000);
    final encodedPrompt = Uri.encodeComponent(prompt);
    return 'https://image.pollinations.ai/prompt/$encodedPrompt?seed=$seed';
  }

  /// Main method to generate image - tries AI Horde first, then falls back
  static Future<String> generateImageWithFallback(String prompt) async {
    try {
      // Try AI Horde first (more reliable but slower)
      return await generateImageWithAIHorde(prompt);
    } catch (e) {
      print("Falling back to Pollinations: $e");
      // Fallback to Pollinations
      return generateImageUrlSimple(prompt);
    }
  }

  /// Quick Pollinations URL (for testing)
  static String generateImageUrl(String prompt) {
    return generateImageUrlSimple(prompt);
  }
}
