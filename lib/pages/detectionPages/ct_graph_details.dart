import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:seedscan2/pages/detectionPages/corn_type_stream.dart';

class ReadingDetailsPage2 extends StatelessWidget {
  final ModelReading2 reading2;

  const ReadingDetailsPage2({Key? key, required this.reading2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define specific colors for labels
    Map<String, Color> labelColors = {
      'White Lagkitan': Colors.grey,
      'Sweet Corn': const Color.fromARGB(255, 232, 70, 124),
    };

    // Fallback for labels without specific colors
    Color getColorForLabel(String label) {
      return labelColors[label] ?? Colors.grey; // Default color for unknown labels
    }

    // Create bar chart data
    List<BarChartGroupData> createBarData() {
      return reading2.labelCounts.entries
          .map(
            (entry) => BarChartGroupData(
              x: entry.key.hashCode, // Unique x-value for the label
              barRods: [
                BarChartRodData(
                  toY: entry.value.toDouble(),
                  color: getColorForLabel(entry.key),
                  width: 16,
                ),
              ],
            ),
          )
          .toList();
    }

    // Create pie chart data
    List<PieChartSectionData> createPieData() {
      final total = reading2.labelCounts.values.fold<int>(0, (sum, count) => sum + count);
      return reading2.labelCounts.entries.map((entry) {
        final percentage = (entry.value / total) * 100;
        return PieChartSectionData(
          color: getColorForLabel(entry.key),
          value: percentage,
          title: '${percentage.toStringAsFixed(1)}%',
          radius: 60,
          titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Details for ${reading2.timestamp}"),
        backgroundColor: const Color.fromARGB(255, 191, 255, 139),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Detection Results Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.lightGreen, width: 1), // Add border
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Detection Results",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(height: 10),
                      ...reading2.labelCounts.entries.map((entry) {
                        return Text(
                          "${entry.key}: ${entry.value}",
                          style: const TextStyle(fontSize: 16),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              // Results Graph Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.lightGreen, width: 1), // Add border
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Results Graph",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 300, // Adjust the height of the graph as needed
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            borderData: FlBorderData(show: false),
                            barGroups: createBarData(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(), // Display the value as an integer
                                      style: const TextStyle(fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final label = reading2.labelCounts.keys.firstWhere(
                                      (key) => key.hashCode == value.toInt(),
                                      orElse: () => '',
                                    );
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(label, style: const TextStyle(fontSize: 12)),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Pie Chart Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.lightGreen, width: 1), // Add border
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Results Distribution",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 300, // Adjust height of the pie chart
                        child: PieChart(
                          PieChartData(
                            sections: createPieData(),
                            centerSpaceRadius: 40,
                            sectionsSpace: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Back Button
              const SizedBox(height: 16), // Spacing before the button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  child: const Text(
                    "Back",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
