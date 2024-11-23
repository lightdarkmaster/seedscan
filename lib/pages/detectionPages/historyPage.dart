import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/liveViabilityDetectionPage.dart';

class HistoryPage extends StatelessWidget {
  final List<ModelReading> readings;

  const HistoryPage({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detection History')),
      body: ListView.builder(
        itemCount: readings.length,
        itemBuilder: (context, index) {
          final reading = readings[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'Detection at ${reading.timestamp}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...reading.labelCounts.entries.map((entry) => Text(
                        '${entry.key}: ${entry.value}',
                      )),
                  const SizedBox(height: 5),
                  Text(
                    'Estimated Harvest: ${reading.calculateEstimatedHarvest()}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
