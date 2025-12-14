/// AI service for generating personalized content using Google Gemini
library ai_service;

import 'package:google_generative_ai/google_generative_ai.dart';

import '../env/app_config.dart';

/// Service for AI-powered content generation
class AIService {
  late GenerativeModel _model;

  AIService() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: AppConfig.geminiApiKey,
    );
  }

  /// Initialize the service
  Future<void> init() async {
    // Model is initialized in constructor
  }

  /// Generate a personalized identity affirmation
  Future<String> generateIdentityAffirmation({
    required String identityName,
    required String category,
    String? recentEvidence,
  }) async {
    final prompt = '''
Generate a personalized identity affirmation for someone who identifies as a "$identityName" in the $category category.

${recentEvidence != null ? 'Recent evidence of this identity: $recentEvidence' : ''}

Requirements:
- Use "I am" statements
- Be specific to the identity
- Be motivating and empowering
- Keep it under 50 words
- Make it feel personal and authentic

Example format: "I am a [identity] who [specific behavior/trait]. Every [action] I take strengthens this identity and moves me closer to [outcome]."
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? 
        'I am a $identityName, and every action I take strengthens this identity.';
    } catch (e) {
      return 'I am a $identityName, and every action I take strengthens this identity.';
    }
  }

  /// Generate a habit suggestion based on identity
  Future<String> generateHabitSuggestion({
    required String identityName,
    required String category,
    String? currentHabits,
  }) async {
    final prompt = '''
Suggest a specific habit for someone who wants to embody the identity of a "$identityName" in the $category category.

${currentHabits != null ? 'They already have these habits: $currentHabits' : ''}

Requirements:
- Suggest ONE specific, actionable habit
- Include When, Where, and How implementation details
- Make it realistic and achievable
- Align with the identity
- Keep the suggestion under 100 words

Format:
Habit: [specific habit name]
When: [specific trigger/time]
Where: [specific location/context]
How: [specific steps to perform]
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? 
        'Focus on one small action that aligns with being a $identityName.';
    } catch (e) {
      return 'Focus on one small action that aligns with being a $identityName.';
    }
  }

  /// Generate a completion celebration message
  Future<String> generateCompletionMessage({
    required String habitName,
    required String identityName,
    int? streakCount,
  }) async {
    final prompt = '''
Generate a celebratory completion message for someone who just completed the habit "$habitName" as part of their "$identityName" identity.

${streakCount != null ? 'This is day $streakCount of their streak.' : ''}

Requirements:
- Be encouraging and identity-focused
- Acknowledge the specific habit
- Reinforce the identity connection
- Keep it under 40 words
- Use emojis appropriately
- Make it feel personal and motivating
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? 
        '🌟 Great job! Every action strengthens your $identityName identity.';
    } catch (e) {
      return '🌟 Great job! Every action strengthens your $identityName identity.';
    }
  }

  /// Generate a weekly insight based on habit data
  Future<String> generateWeeklyInsight({
    required List<Map<String, dynamic>> weeklyData,
    required String identityName,
  }) async {
    final completedHabits = weeklyData.where((d) => d['completed'] == true).length;
    final totalHabits = weeklyData.length;
    final completionRate = totalHabits > 0 
        ? (completedHabits / totalHabits * 100).round() 
        : 0;

    final prompt = '''
Generate a weekly insight for someone working on their "$identityName" identity.

Weekly stats:
- Completed $completedHabits out of $totalHabits planned habits
- Completion rate: $completionRate%

Requirements:
- Be encouraging regardless of performance
- Focus on identity reinforcement
- Provide actionable insight for next week
- Keep it under 80 words
- Be specific to their progress
- End with motivation
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? 
        'Every step you take strengthens your $identityName identity. Keep building!';
    } catch (e) {
      return 'Every step you take strengthens your $identityName identity. Keep building!';
    }
  }

  /// Generate environment optimization suggestions
  Future<String> generateEnvironmentSuggestion({
    required String identityName,
    required String habitName,
    String? currentEnvironment,
  }) async {
    final prompt = '''
Suggest environmental changes to support the habit "$habitName" for someone embodying the "$identityName" identity.

${currentEnvironment != null ? 'Current environment: $currentEnvironment' : ''}

Requirements:
- Suggest 2-3 specific environmental modifications
- Make them practical and achievable
- Focus on making the habit easier/more obvious
- Align with the identity
- Keep it under 100 words
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? 
        'Set up your environment to make being a $identityName easier and more natural.';
    } catch (e) {
      return 'Set up your environment to make being a $identityName easier and more natural.';
    }
  }
}
