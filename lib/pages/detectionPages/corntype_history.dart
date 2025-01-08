import 'package:flutter/material.dart';
import 'package:seedscan2/data/corntype_database_helper.dart';
import 'package:seedscan2/pages/detectionPages/corn_type_stream.dart';
import 'package:seedscan2/pages/detectionPages/ct_graph_details.dart';

class HistoryPage2 extends StatefulWidget {
  @override
  _HistoryPage2State createState() => _HistoryPage2State();
}

class _HistoryPage2State extends State<HistoryPage2> {
  late Future<List<ModelReading2>> readings2;

  @override
  void initState() {
    super.initState();
    readings2 = DatabaseHelper2().fetchReadings2();
  }

  Future<void> deleteReading2(int id) async {
    await DatabaseHelper2().deleteReading2(id);
    setState(() {
      readings2 = DatabaseHelper2().fetchReadings2();
    });
  }

  Future<void> deleteAllReadings() async {
    await DatabaseHelper2().deleteAllReadings2();
    setState(() {
      readings2 = DatabaseHelper2().fetchReadings2();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Corn Type History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 191, 255, 139),
        toolbarHeight: 50,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep, color: Colors.blue),
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
      body: FutureBuilder<List<ModelReading2>>(
        future: readings2,
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
                final reading2 = snapshot.data![index];

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
                              ReadingDetailsPage2(reading2: reading2),
                        ),
                      );
                    },
                    title: Text(
                      "Timestamp: ${reading2.timestamp}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...reading2.labelCounts.entries.map(
                          (entry) => Text("${entry.key}: ${entry.value}"),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.blue),
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
                          deleteReading2(reading2.id);
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
