import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/historyManager.dart';
import 'package:seedscan2/pages/detectionPages/historyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class YoloVideo extends StatefulWidget {
  const YoloVideo({super.key});

  @override
  State<YoloVideo> createState() => _YoloVideoState();
}

class _YoloVideoState extends State<YoloVideo> with WidgetsBindingObserver {
  late CameraController controller;
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;

  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  double confidenceThreshold = 0.4;

  List<ModelReading> history = [];


  Future<void> saveHistoryToStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> jsonList = history.map((entry) => jsonEncode(entry.toJson())).toList();
  await prefs.setStringList('history', jsonList);
}

  
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);
   loadHistoryFromStorage(); // Load saved history
  init();
}


Future<void> loadHistoryFromStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonList = prefs.getStringList('history');
  if (jsonList != null) {
    setState(() {
      history = jsonList.map((entry) => ModelReading.fromJson(jsonDecode(entry))).toList();
    });
  }
}



Future<void> init() async {
  List<CameraDescription> cameras = await availableCameras();
  vision = FlutterVision();
  controller = CameraController(cameras[0], ResolutionPreset.high);
  await controller.initialize();

  // Load YOLO model
  await loadYoloModel();

  // Load saved history
  history = await HistoryManager.loadHistory();

  setState(() {
    isLoaded = true;
    isDetecting = false;
    yoloResults = [];
  });
}


  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
      labels: 'assets/models/vLabels.txt',
      modelPath: 'assets/models/V-Final103M.tflite',
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
      iouThreshold: 0.45,
      confThreshold: 0.51,
      classThreshold: 0.70,
    );
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
      });
    }
  }

void saveDetectionResults() {
  Map<String, int> labelCounts = {};

  for (var result in yoloResults) {
    String label = result['tag'];
    labelCounts[label] = (labelCounts[label] ?? 0) + 1; // Count occurrences
  }

  history.add(ModelReading(
    labelCounts: labelCounts,
    timestamp: DateTime.now(),
  ));

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Results saved to history!')),
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

int getEstimatedHarvest() {
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
    int estimatedHarvest = getEstimatedHarvest();

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
                      icon: const Icon(Icons.save),
                      label: const Text("Save History"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryPage(readings: history),
                          ),
                        );
                      },
                      icon: const Icon(Icons.history),
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
      'viable': Colors.green,
      'less-viable': Colors.blue,
      'non-viable': Colors.red,
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
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              color: boxColor.withOpacity(0.7),
              child: Text(
                "$label ${(result['box'][4] * 100).toStringAsFixed(1)}%",
                style: const TextStyle(color: Colors.white, fontSize: 10.0),
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


class ModelReading {
  final Map<String, int> labelCounts;
  final DateTime timestamp;

  ModelReading({
    required this.labelCounts,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'labelCounts': labelCounts,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ModelReading.fromJson(Map<String, dynamic> json) {
    return ModelReading(
      labelCounts: Map<String, int>.from(json['labelCounts']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  calculateEstimatedHarvest() {}
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: YoloVideo(),
  ));
}
