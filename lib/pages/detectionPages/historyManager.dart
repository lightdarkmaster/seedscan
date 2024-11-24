import 'dart:convert';
import 'package:seedscan2/pages/detectionPages/liveViabilityDetectionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryManager {
  static const String _key = 'historyKey';

  static Future<void> saveHistory(List<ModelReading> history) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonHistory =
        history.map((reading) => jsonEncode(reading.toJson())).toList();
    await prefs.setStringList(_key, jsonHistory);
  }

  static Future<List<ModelReading>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonHistory = prefs.getStringList(_key);
    if (jsonHistory == null) return [];
    return jsonHistory
        .map((jsonString) => ModelReading.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
