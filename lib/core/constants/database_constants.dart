/// Database constants for Appwrite collections and configuration
library database_constants;

import '../env/app_config.dart';

class DatabaseConstants {
  // Database ID from environment
  static String get databaseId => AppConfig.appwriteDatabaseId;
  
  // Collection Names
  static const String usersCollection = 'users';
  static const String habitsCollection = 'habits';
  static const String completionsCollection = 'completions';
  static const String evidenceCollection = 'evidence';
  static const String environmentCollection = 'environment';
  static const String insightsCollection = 'insights';
  static const String affirmationTemplatesCollection = 'affirmation_templates';
  static const String completionEventsCollection = 'completion_events';
  static const String identitiesCollection = 'identities';
  static const String affirmationsCollection = 'affirmations';
  static const String notificationsCollection = 'notifications';
  static const String habitCompletionsCollection = 'habit_completions';
  static const String userSettingsCollection = 'user_settings';
  static const String identityScoresCollection = 'identity_scores';
  static const String scoreHistoryCollection = 'score_history';
  static const String milestonesCollection = 'milestones';
  static const String scoreComponentConfigsCollection = 'score_component_configs';
  static const String habitStacksCollection = 'habit_stacks';
  
  // Collection getters
  static String get usersTable => usersCollection;
  static String get habitsTable => habitsCollection;
  static String get completionsTable => completionsCollection;
  static String get evidenceTable => evidenceCollection;
  static String get environmentTable => environmentCollection;
  static String get insightsTable => insightsCollection;
  static String get affirmationTemplatesTable => affirmationTemplatesCollection;
  static String get completionEventsTable => completionEventsCollection;
  static String get identitiesTable => identitiesCollection;
  static String get affirmationsTable => affirmationsCollection;
  static String get notificationsTable => notificationsCollection;
  static String get habitCompletionsTable => habitCompletionsCollection;
  static String get userSettingsTable => userSettingsCollection;
  static String get identityScoresTable => identityScoresCollection;
  static String get scoreHistoryTable => scoreHistoryCollection;
  static String get milestonesTable => milestonesCollection;
  static String get scoreComponentConfigsTable => scoreComponentConfigsCollection;
  static String get habitStacksTable => habitStacksCollection;
}
