import 'dart:convert';
import 'package:path/path.dart';
import 'package:seedscan2/pages/detectionPages/corn_type_stream.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper2 {
  static final DatabaseHelper2 _instance = DatabaseHelper2._internal();
  factory DatabaseHelper2() => _instance;

  static Database? _database;

  DatabaseHelper2._internal();

  // Singleton pattern for accessing the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cornType_history.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            labelCounts TEXT NOT NULL,
            timestamp TEXT NOT NULL
          )
        ''');
        print("TABLE CREATED!");
      },
    );
  }

  // Insert a new reading2 into the database
  Future<int> insertReading2(ModelReading2 reading2) async {
    final db = await database;
    return await db.insert(
      'history',
      {
        'labelCounts': jsonEncode(reading2.labelCounts), // Convert map to JSON string
        'timestamp': reading2.timestamp.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all readings from the database
  Future<List<ModelReading2>> fetchReadings2() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history');

    return List.generate(maps.length, (i) {
      return ModelReading2.fromJson(maps[i]);
    });
  }

  // Delete all readings from the database
  Future<void> deleteAllReadings2() async {
    final db = await database;
    await db.delete('history');
  }

  // Reset the database (clear history)
  Future<void> resetDatabase2() async {
    final db = await database;
    await db.delete('history');
  }

  // Delete a specific reading2 by id
  Future<void> deleteReading2(int id) async {
    final db = await database; // Use your existing database getter
    await db.delete(
      'history', // Correct table name
      where: 'id = ?', // SQL WHERE clause
      whereArgs: [id], // Arguments for the WHERE clause
    );
  }
}
