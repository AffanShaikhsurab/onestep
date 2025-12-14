/// Application-wide constants and configuration values
library app_constants;

class AppConstants {
  // App Information
  static const String appName = 'OneStep';
  static const String appTagline = 'Become who you want to be';
  
  // Identity Categories
  static const List<String> identityCategories = [
    'Health & Fitness',
    'Career & Professional',
    'Relationships & Social',
    'Personal Growth',
    'Creative & Artistic',
    'Financial',
    'Spiritual & Mindfulness',
    'Learning & Education',
    'Community & Service',
    'Adventure & Travel',
  ];
  
  // Habit Frequencies
  static const List<String> habitFrequencies = [
    'Daily',
    'Weekly',
    'Monthly',
    'Custom',
  ];
  
  // Evidence Types
  static const List<String> evidenceTypes = [
    'Photo',
    'Note',
    'Achievement',
    'Reflection',
  ];
  
  // Notification Types
  static const String notificationTypeHabit = 'habit_reminder';
  static const String notificationTypeAffirmation = 'affirmation';
  static const String notificationTypeReflection = 'reflection';
  static const String notificationTypeWeeklyReview = 'weekly_review';
  
  // Database Tables
  static const String tableUsers = 'users';
  static const String tableHabits = 'habits';
  static const String tableCompletions = 'completions';
  static const String tableEvidence = 'evidence';
  static const String tableEnvironment = 'environment';
  static const String tableInsights = 'insights';
  static const String tableIdentities = 'identities';
  static const String tableAffirmations = 'affirmations';
  static const String tableNotifications = 'notifications';
  static const String tableHabitStacks = 'habit_stacks';
  static const String habitCompletionsTable = 'habit_completions';
  
  // Collection IDs for Appwrite
  static String get usersCollectionId => tableUsers;
  static String get habitsCollectionId => tableHabits;
  static String get completionsCollectionId => tableCompletions;
  static String get evidenceCollectionId => tableEvidence;
  static String get environmentCollectionId => tableEnvironment;
  static String get insightsCollectionId => tableInsights;
  static String get identitiesCollectionId => tableIdentities;
  static String get affirmationsCollectionId => tableAffirmations;
  static String get notificationsCollectionId => tableNotifications;
  static String get habitStacksCollectionId => tableHabitStacks;
  
  // Shared Preferences Keys
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const String keySelectedIdentities = 'selected_identities';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyDarkMode = 'dark_mode';
  
  // Animation Durations
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 400);
  static const Duration animationDurationLong = Duration(milliseconds: 600);
  
  // UI Constants
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 24.0;
  
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  // Identity Scorecard
  static const int maxScorePerIdentity = 100;
  static const int evidencePointsPhoto = 5;
  static const int evidencePointsNote = 3;
  static const int evidencePointsAchievement = 10;
  static const int evidencePointsReflection = 7;
  
  // Habit Streaks
  static const int streakBronze = 7;
  static const int streakSilver = 30;
  static const int streakGold = 90;
  static const int streakPlatinum = 365;
}
