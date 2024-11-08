import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter/material.dart';

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

class _YoloVideoState extends State<YoloVideo> {
  late CameraController controller;
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;

  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  double confidenceThreshold = 0.4; //.5

  @override
  void initState() {
    super.initState();
    init();
  }

  // Initialize the camera and YOLO model
  Future<void> init() async {
    List<CameraDescription> cameras = await availableCameras();
    vision = FlutterVision();
    controller = CameraController(cameras[0], ResolutionPreset.high); // high
    await controller.initialize();

    await loadYoloModel();

    setState(() {
      isLoaded = true;
      isDetecting = false;
      yoloResults = [];
    });
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
      labels: 'assets/models/labels.txt',
      modelPath: 'assets/models/Corn_types_float16.tflite',
      modelVersion: "yolov8",
      numThreads: 1,
      useGpu: false,//true
    );
  }

  // Start detection stream
  Future<void> startDetection() async {
    if (isDetecting) return; // Prevent multiple streams
    setState(() {
      isDetecting = true;
    });

    await controller.startImageStream((image) async {
      if (!isDetecting) return; // Check if we should keep detecting
      cameraImage = image;
      await yoloOnFrame(image);
    });
  }

  // Stop detection stream
  Future<void> stopDetection() async {
    setState(() {
      isDetecting = false;
      yoloResults.clear();
    });
    await controller.stopImageStream();
  }

  // Process frame with YOLO model
  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
      bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
      iouThreshold: 0.4,
      confThreshold: 0.5,
      classThreshold: 0.5,
    );
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
      });
    }
  }

  // Display detected objects
  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty || cameraImage == null) return [];

    double factorX = screen.width / cameraImage!.height;
    double factorY = screen.height / cameraImage!.width;

    return yoloResults.map((result) {
      double objectX = result["box"][0] * factorX;
      double objectY = result["box"][1] * factorY;
      double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
      double objectHeight = (result["box"][3] - result["box"][1]) * factorY;

      return Stack(
        children: [
          // Position the label above the bounding box
          Positioned(
            left: objectX,
            top: objectY - 20, // Adjust the label's position above the bounding box
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              color: const Color.fromARGB(255, 244, 97, 97).withOpacity(0.7),
              child: Text(
                "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(1)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
            ),
          ),
          // The bounding box
          Positioned(
            left: objectX,
            top: objectY,
            width: objectWidth,
            height: objectHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                border: Border.all(color: Colors.pink, width: 1.0),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  // Function to count labels and occurrences
  Map<String, int> getLabelCounts() {
    Map<String, int> labelCounts = {};

    for (var result in yoloResults) {
      String label = result['tag'];
      if (labelCounts.containsKey(label)) {
        labelCounts[label] = labelCounts[label]! + 1;
      } else {
        labelCounts[label] = 1;
      }
    }

    return labelCounts;
  }

  @override
  void dispose() {
    controller.dispose();
    vision.closeYoloModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Model not loaded, waiting for it..."),
        ),
      );
    }

    Map<String, int> labelCounts = getLabelCounts(); // Get label counts

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
          ...displayBoxesAroundRecognizedObjects(screenSize),
          Positioned(
            bottom: 55,
            width: screenSize.width,
            child: Center(
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
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
                  color: isDetecting ? Colors.red : Colors.white,
                  iconSize: 20,
                ),
              ),
            ),
          ),
          // Card displaying labels and number of detections
          Positioned(
            top: 50,
            left: 10,
            child: Card(
              color: Colors.black.withOpacity(0.7),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: labelCounts.entries.map((entry) {
                    return Text(
                      '${entry.key}: ${entry.value}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: YoloVideo(),
  ));
}
