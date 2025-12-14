/// Local SQLite database service for offline-first functionality
library database_service;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import '../constants/app_constants.dart';

/// Service for managing local SQLite database
class DatabaseService {
  static Database? _database;
  static const String _databaseName = 'onestep.db';
  static const int _databaseVersion = 1;

  /// Initialize database
  Future<void> init() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    await database;
  }

  /// Get database instance
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Identities table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableIdentities} (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT,
        isActive INTEGER NOT NULL DEFAULT 1,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        syncStatus INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Habits table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableHabits} (
        id TEXT PRIMARY KEY,
        identityId TEXT NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        whenCondition TEXT NOT NULL,
        whereCondition TEXT NOT NULL,
        howCondition TEXT NOT NULL,
        frequency TEXT NOT NULL,
        isActive INTEGER NOT NULL DEFAULT 1,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        syncStatus INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (identityId) REFERENCES ${AppConstants.tableIdentities} (id)
      )
    ''');

    // Evidence table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableEvidence} (
        id TEXT PRIMARY KEY,
        identityId TEXT NOT NULL,
        habitId TEXT,
        type TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        imageUrl TEXT,
        completedAt TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        syncStatus INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (identityId) REFERENCES ${AppConstants.tableIdentities} (id),
        FOREIGN KEY (habitId) REFERENCES ${AppConstants.tableHabits} (id)
      )
    ''');

    // Habit completions table
    await db.execute('''
      CREATE TABLE ${AppConstants.habitCompletionsTable} (
        id TEXT PRIMARY KEY,
        habitId TEXT NOT NULL,
        completedAt TEXT NOT NULL,
        notes TEXT,
        evidenceId TEXT,
        createdAt TEXT NOT NULL,
        syncStatus INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (habitId) REFERENCES ${AppConstants.tableHabits} (id),
        FOREIGN KEY (evidenceId) REFERENCES ${AppConstants.tableEvidence} (id)
      )
    ''');

    // Notifications table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableNotifications} (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        data TEXT,
        isRead INTEGER NOT NULL DEFAULT 0,
        scheduledAt TEXT,
        createdAt TEXT NOT NULL
      )
    ''');

    // User settings table
    await db.execute('''
      CREATE TABLE user_settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    // Identity scores table
    await db.execute('''
      CREATE TABLE identity_scores (
        userId TEXT PRIMARY KEY,
        score INTEGER NOT NULL,
        stage TEXT NOT NULL,
        components TEXT NOT NULL,
        milestones TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    // Score history table
    await db.execute('''
      CREATE TABLE score_history (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        score INTEGER NOT NULL,
        stage TEXT NOT NULL,
        components TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    // Milestones table
    await db.execute('''
      CREATE TABLE milestones (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        type TEXT NOT NULL,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        identityStage TEXT NOT NULL,
        scoreThreshold INTEGER NOT NULL,
        isAchieved INTEGER NOT NULL DEFAULT 0,
        achievedAt TEXT,
        notifiedAt TEXT,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations
  }

  /// Insert a row into a table
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  /// Query rows from a table
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  /// Query first row from a table
  Future<Map<String, dynamic>?> queryFirst(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final results = await query(
      table,
      where: where,
      whereArgs: whereArgs,
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// Update rows in a table
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  /// Delete rows from a table
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  /// Close database connection
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
