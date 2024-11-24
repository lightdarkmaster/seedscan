import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/historyManager.dart';
import 'package:seedscan2/pages/detectionPages/liveViabilityDetectionPage.dart';

class HistoryPage extends StatelessWidget {
  final List<ModelReading> readings;

  const HistoryPage({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detection History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // Confirm clear history
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Clear History"),
                  content: const Text(
                      "Are you sure you want to delete all detection history?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Clear"),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await HistoryManager.clearHistory();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("History cleared!")),
                );

                // Close history page after clearing
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: readings.isEmpty
          ? const Center(child: Text("No history available."))
          : ListView.builder(
              itemCount: readings.length,
              itemBuilder: (context, index) {
                final reading = readings[index];
                return ListTile(
                  title: Text(
                    "Date: ${reading.timestamp}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...reading.labelCounts.entries.map(
                        (entry) => Text("${entry.key}: ${entry.value}"),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
