import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter/material.dart';
import 'package:seedscan2/data/corntype_database_helper.dart';
import 'package:seedscan2/pages/detectionPages/corntype_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraPage3 extends StatefulWidget {
  const CameraPage3({super.key});

  @override
  State<CameraPage3> createState() => _CameraPage3State();
}

class _CameraPage3State extends State<CameraPage3> {
  late List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class YoloVideo3 extends StatefulWidget {
  const YoloVideo3({super.key});

  @override
  State<YoloVideo3> createState() => _YoloVideo3State();
}

class _YoloVideo3State extends State<YoloVideo3> with WidgetsBindingObserver {
  late CameraController controller;
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;
  final DatabaseHelper2 dbHelper = DatabaseHelper2();

  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  double confidenceThreshold = 0.4;

  List<ModelReading2> history = [];

  Future<void> saveHistoryToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        history.map((entry) => jsonEncode(entry.toJson())).toList();
    await prefs.setStringList('history', jsonList);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);
    //loadHistoryFromStorage(); // Load saved history
    loadHistory();
    init();
  }

  Future<void> loadHistoryFromStorage() async {
    final fetchedHistory2 = await dbHelper.fetchReadings2();
    setState(() {
      history = fetchedHistory2;
    });
  }

  Future<void> loadHistory() async {
    List<ModelReading2> savedReadings = await DatabaseHelper2().fetchReadings2();
    setState(() {
      history = savedReadings;
    });
  }

  Future<void> init() async {
    List<CameraDescription> cameras = await availableCameras();
    vision = FlutterVision();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();

    // Load YOLO model
    await loadYoloModel();

    // Load saved history
    //history = await HistoryManager.loadHistory();

    setState(() {
      isLoaded = true;
      isDetecting = false;
      yoloResults = [];
    });
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
      labels: 'assets/models/labels.txt',
      modelPath: 'assets/models/cornTypeFinal104.tflite',
      modelVersion: "yolov8",
      numThreads: 1,
      useGpu: false,
    );
  }

  Future<void> startDetection() async {
    if (isDetecting) return;
    setState(() {
      isDetecting = true;
    });

    await controller.startImageStream((image) async {
      if (!isDetecting) return;
      cameraImage = image;
      await yoloOnFrame(image);
    });
  }

  Future<void> stopDetection() async {
    setState(() {
      isDetecting = false;
      yoloResults.clear();
    });
    await controller.stopImageStream();
  }

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
      bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
      iouThreshold: 0.5,
      confThreshold: 0.55,
      classThreshold: 0.55,
    );
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
      });
    }
  }

  Future<void> saveDetectionResults() async {
    Map<String, int> labelCounts = getLabelCounts();

    // Create a new ModelReading2 object (id is not needed yet)
    final reading2 = ModelReading2(
      id: 0, // Temporary id, will be updated after inserting into DB
      labelCounts: labelCounts,
      timestamp: DateTime.now(),
    );

    // Save to history (memory)
    setState(() {
      history.add(reading2); // This is storing in-memory, without the id
    });

    // Save to SQLite and get the inserted id
    final insertedId = await dbHelper
        .insertReading2(reading2); // Assume insertReading2 returns the id

    // Update the reading2 object with the assigned id
    setState(() {
      reading2.id = insertedId;
    });

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Row(
      children: [
        Image.asset(
          'assets/images/success.gif', // Replace with your GIF path
          height: 40,                  // Adjust the size as needed
        ),
        const SizedBox(width: 10),
        const Text("Detection results saved to history!"),
      ],
    ),
    duration: const Duration(seconds: 3), // Adjust display duration
    backgroundColor: Colors.green,       // Optional: change the background color
  ),
);

  }

  Map<String, int> getLabelCounts() {
    Map<String, int> labelCounts = {};
    for (var result in yoloResults) {
      String label = result['tag'];
      labelCounts[label] = (labelCounts[label] ?? 0) + 1;
    }
    return labelCounts;
  }

  int getTotalDetections() {
    int viableCount = 0;

    for (var result in yoloResults) {
      String label = result['tag'];
      if (label == 'Viable') {
        viableCount++;
      }
    }

    return viableCount * 4; // Each viable seed counts as 4
  }

  @override
  void dispose() async {
    await saveHistoryToStorage(); // Save history before exiting
    if (isDetecting) {
      await stopDetection();
    }
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    await controller.dispose();
    await vision.closeYoloModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (!isLoaded) {
      return const Scaffold(
        body: Center(child: Text("Model not loaded, waiting for it...")),
      );
    }

    Map<String, int> labelCounts = getLabelCounts();
    int estimatedHarvest = getTotalDetections();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
          // Display detected objects
          ...displayBoxesAroundRecognizedObjects(screenSize),
          // Top Buttons: Save to History & View History
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: saveDetectionResults,
                      icon: const Icon(
                        Icons.save,
                        color:
                            Colors.black, // Change this to your desired color
                      ),
                      label: const Text("Save History"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryPage2(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.history,
                      color: Colors.black,
                      ),
                      label: const Text("View History"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Labels Detected:",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ...labelCounts.entries.map((entry) => Text(
                      "${entry.key}: ${entry.value}",
                      style: const TextStyle(fontSize: 14),
                    )),
                const SizedBox(height: 10),
                Text(
                  "Estimated Harvest: $estimatedHarvest",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Bottom Detection Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  color: isDetecting ? Colors.red : Colors.green,
                ),
                child: IconButton(
                  onPressed: () async {
                    if (isDetecting) {
                      await stopDetection();
                    } else {
                      await startDetection();
                    }
                  },
                  icon: Icon(isDetecting ? Icons.stop : Icons.play_arrow),
                  color: Colors.white,
                  iconSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty || cameraImage == null) return [];

    double factorX = screen.width / cameraImage!.height;
    double factorY = screen.height / cameraImage!.width;

    Map<String, Color> labelColors = {
      'white lagkitan': Colors.white,
      'sweet corn': Colors.amber,
    };

    return yoloResults.map((result) {
      double objectX = result["box"][0] * factorX;
      double objectY = result["box"][1] * factorY;
      double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
      double objectHeight = (result["box"][3] - result["box"][1]) * factorY;

      String label = result['tag'];
      Color boxColor = labelColors[label.toLowerCase()] ?? Colors.grey;

      return Stack(
        children: [
          Positioned(
            left: objectX,
            top: objectY - 20,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              color: boxColor.withOpacity(0.7),
              child: Text(
                "$label ${(result['box'][4] * 100).toStringAsFixed(1)}%",
                style: const TextStyle(color: Colors.black, fontSize: 10.0),
              ),
            ),
          ),
          Positioned(
            left: objectX,
            top: objectY,
            width: objectWidth,
            height: objectHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                border: Border.all(color: boxColor, width: 1.0),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}

class ModelReading2 {
  late final int id;
  final Map<String, int> labelCounts;
  final DateTime timestamp;

  ModelReading2({
    required this.id,
    required this.labelCounts,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include id in the JSON serialization
      'labelCounts': jsonEncode(labelCounts), // Convert map to JSON string
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ModelReading2.fromJson(Map<String, dynamic> json) {
    try {
      final decodedLabelCounts =
          jsonDecode(json['labelCounts']) as Map<String, dynamic>;
      final labelCountsMap = decodedLabelCounts.map(
        (key, value) => MapEntry(key, int.parse(value.toString())),
      );

      return ModelReading2(
        id: json['id'], // Extract the id from the database
        labelCounts: labelCountsMap,
        timestamp: DateTime.parse(json['timestamp']),
      );
    } catch (e) {
      print("Error decoding labelCounts: $e");
      final fallback = <String, int>{};
      final rawLabelCounts = json['labelCounts'] as String;
      rawLabelCounts
          .substring(1, rawLabelCounts.length - 1) // Remove surrounding braces
          .split(',') // Split by commas
          .forEach((entry) {
        final keyValue = entry.split('=');
        if (keyValue.length == 2) {
          fallback[keyValue[0].trim()] = int.tryParse(keyValue[1].trim()) ?? 0;
        }
      });

      return ModelReading2(
        id: json['id'], // Extract the id from the database
        labelCounts: fallback,
        timestamp: DateTime.parse(json['timestamp']),
      );
    }
  }

  // Safely calculate estimated harvest
  int calculateEstimatedHarvest() {
    final viableCount =
        labelCounts['Viable'] ?? 0; // Default to 0 if 'Viable' is null
    return viableCount * 4;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: YoloVideo3(),
  ));
}
