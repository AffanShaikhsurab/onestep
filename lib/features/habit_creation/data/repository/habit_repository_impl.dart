import 'package:appwrite/appwrite.dart';

import '../../../../core/constants/database_constants.dart';
import '../../../../core/services/appwrite_service.dart';
import '../entities/habit_entity.dart';
import 'habit_repository.dart';

/// Appwrite implementation of HabitRepository
class HabitRepositoryImpl implements HabitRepository {
  final AppwriteService _appwriteService;

  HabitRepositoryImpl(this._appwriteService);

  Databases get _databases => _appwriteService.databases;

  @override
  Future<HabitEntity> createHabit(HabitEntity habit) async {
    try {
      final response = await _databases.createDocument(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.habitsCollectionId,
        documentId: ID.unique(),
        data: habit.toJson(),
      );

      return HabitEntity.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create habit: $e');
    }
  }

  @override
  Future<List<HabitEntity>> getAllHabits(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.habitsCollectionId,
        queries: [
          Query.equal('user_id', userId),
          Query.orderDesc('created_at'),
        ],
      );

      return response.documents
          .map((doc) => HabitEntity.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to get habits: $e');
    }
  }

  @override
  Future<List<HabitEntity>> getHabitsByIdentity(String identityId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.habitsCollectionId,
        queries: [
          Query.equal('identity_id', identityId),
          Query.orderDesc('created_at'),
        ],
      );

      return response.documents
          .map((doc) => HabitEntity.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to get habits by identity: $e');
    }
  }

  @override
  Future<HabitEntity> getHabitById(String habitId) async {
    try {
      final response = await _databases.getDocument(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.habitsCollectionId,
        documentId: habitId,
      );

      return HabitEntity.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get habit: $e');
    }
  }

  @override
  Future<HabitEntity> updateHabit(HabitEntity habit) async {
    try {
      final response = await _databases.updateDocument(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.habitsCollectionId,
        documentId: habit.id,
        data: habit.toJson(),
      );

      return HabitEntity.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update habit: $e');
    }
  }

  @override
  Future<void> deleteHabit(String habitId) async {
    try {
      await _databases.deleteDocument(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.habitsCollectionId,
        documentId: habitId,
      );
    } catch (e) {
      throw Exception('Failed to delete habit: $e');
    }
  }

  @override
  Future<void> toggleHabitStatus(String habitId, bool isActive) async {
    try {
      await _databases.updateDocument(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.habitsCollectionId,
        documentId: habitId,
        data: {'is_active': isActive, 'last_updated': DateTime.now().toIso8601String()},
      );
    } catch (e) {
      throw Exception('Failed to toggle habit status: $e');
    }
  }
}
