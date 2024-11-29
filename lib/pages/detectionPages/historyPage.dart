import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/database_helper.dart'; // Import the database helper
import 'package:seedscan2/pages/detectionPages/liveViabilityDetectionPage.dart'; // Import your ModelReading

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<ModelReading>> readings;

  @override
  void initState() {
    super.initState();
    readings = DatabaseHelper().fetchReadings(); // Load readings from SQLite
  }

  // Function to delete reading and refresh the list
  Future<void> deleteReading(int id) async {
    await DatabaseHelper().deleteReading(id);
    setState(() {
      readings = DatabaseHelper().fetchReadings(); // Refresh the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detection History"),
      ),
      body: FutureBuilder<List<ModelReading>>(
        future: readings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No history available."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final reading = snapshot.data![index];
                final estimatedHarvest = reading.calculateEstimatedHarvest();

                return ListTile(
                  title: Text(
                    "Timestamp: ${reading.timestamp}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...reading.labelCounts.entries.map(
                        (entry) => Text("${entry.key}: ${entry.value}"),
                      ),
                      Text(
                        "Estimated Harvest: $estimatedHarvest",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Delete the current reading using the id
                      deleteReading(reading.id);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
