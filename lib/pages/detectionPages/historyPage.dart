import 'package:flutter/material.dart';
import 'package:seedscan2/data/database_helper.dart';
import 'package:seedscan2/pages/detectionPages/graph_details.dart';
import 'package:seedscan2/pages/detectionPages/liveViabilityDetectionPage.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<ModelReading>> readings;

  @override
  void initState() {
    super.initState();
    readings = DatabaseHelper().fetchReadings();
  }

  Future<void> deleteReading(int id) async {
    await DatabaseHelper().deleteReading(id);
    setState(() {
      readings = DatabaseHelper().fetchReadings();
    });
  }

  Future<void> deleteAllReadings() async {
    await DatabaseHelper().deleteAllReadings();
    setState(() {
      readings = DatabaseHelper().fetchReadings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Corn Viability History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 191, 255, 139),
        toolbarHeight: 50,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep, color: Colors.red),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete All"),
                    content: const Text(
                        "Are you sure you want to delete all history?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.black)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Delete All",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );

              if (confirm == true) {
                await deleteAllReadings();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Image.asset(
                          'assets/images/success.gif', // Replace with your GIF path
                          height: 40, // Adjust the size as needed
                        ),
                        const SizedBox(width: 10),
                        const Text("History Deleted Successfully!"),
                      ],
                    ),
                    duration:
                        const Duration(seconds: 3), // Adjust display duration
                    backgroundColor:
                        Colors.green, // Optional: change the background color
                  ),
                );
              }
            },
          ),
        ],
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

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    onTap: () {
                      // Navigate to the details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReadingDetailsPage(reading: reading),
                        ),
                      );
                    },
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
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Delete Reading"),
                              content: const Text(
                                  "Are you sure you want to delete this entry?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Delete",
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          deleteReading(reading.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/success.gif', // Replace with your GIF path
                                    height: 40, // Adjust the size as needed
                                  ),
                                  const SizedBox(width: 10),
                                  const Text("Deleted Successfully!"),
                                ],
                              ),
                              duration: const Duration(
                                  seconds: 3), // Adjust display duration
                              backgroundColor: Colors
                                  .green, // Optional: change the background color
                            ),
                          );
                        }
                      },
                    ),
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
