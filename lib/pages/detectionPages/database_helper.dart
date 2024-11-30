import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:seedscan2/pages/detectionPages/liveViabilityDetectionPage.dart'; // Adjust the import if needed

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  // Singleton pattern for accessing the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'history.db');

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

  // Insert a new reading into the database
  Future<int> insertReading(ModelReading reading) async {
    final db = await database;
    return await db.insert(
      'history',
      {
        'labelCounts': jsonEncode(reading.labelCounts), // Convert map to JSON string
        'timestamp': reading.timestamp.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all readings from the database
  Future<List<ModelReading>> fetchReadings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history');

    return List.generate(maps.length, (i) {
      return ModelReading.fromJson(maps[i]);
    });
  }

  // Delete all readings from the database
  Future<void> deleteAllReadings() async {
    final db = await database;
    await db.delete('history');
  }

  // Reset the database (clear history)
  Future<void> resetDatabase() async {
    final db = await database;
    await db.delete('history');
  }

  // Delete a specific reading by id
  Future<void> deleteReading(int id) async {
    final db = await database; // Use your existing database getter
    await db.delete(
      'history', // Correct table name
      where: 'id = ?', // SQL WHERE clause
      whereArgs: [id], // Arguments for the WHERE clause
    );
  }
}
