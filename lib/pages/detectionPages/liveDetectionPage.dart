import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';

class LiveDetectionPage extends StatelessWidget {
  const LiveDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YoloVideo();
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
  List<CameraDescription> cameras = [];
  bool isLoaded = false;
  bool isDetecting = false;
  double confidenceThreshold = 0.4;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      cameras = await availableCameras();
      vision = FlutterVision();
      controller = CameraController(cameras[0], ResolutionPreset.high);

      await controller.initialize();
      await loadYoloModel();

      setState(() {
        isLoaded = true;
        yoloResults = [];
      });
    } catch (e) {
      debugPrint("Initialization error: $e");
    }
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
      labels: 'assets/labels.txt',
      modelPath: 'assets/myModel.tflite',
      modelVersion: "yolov8",
      numThreads: 1,
      useGpu: true,
    );
  }

  Future<void> startDetection() async {
    if (isDetecting) return;
    setState(() {
      isDetecting = true;
    });

    controller.startImageStream((image) async {
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

  Future<void> yoloOnFrame(CameraImage image) async {
    if (isDetecting) {
      final result = await vision.yoloOnFrame(
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        iouThreshold: 0.4,
        confThreshold: confidenceThreshold,
        classThreshold: confidenceThreshold,
      );
      setState(() {
        yoloResults = result;
      });
    }
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty || cameraImage == null) return [];

    double factorX = screen.width / cameraImage!.height;
    double factorY = screen.height / cameraImage!.width;

    return yoloResults.map((result) {
      double x = result["box"][0] * factorX;
      double y = result["box"][1] * factorY;
      double width = (result["box"][2] - result["box"][0]) * factorX;
      double height = (result["box"][3] - result["box"][1]) * factorY;

      return Stack(
        children: [
          Positioned(
            left: x,
            top: y - 20,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              color: Colors.red.withOpacity(0.7),
              child: Text(
                "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(1)}%",
                style: const TextStyle(color: Colors.white, fontSize: 10.0),
              ),
            ),
          ),
          Positioned(
            left: x,
            top: y,
            width: width,
            height: height,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink, width: 1.0),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  Map<String, int> getLabelCounts() {
    Map<String, int> labelCounts = {};
    for (var result in yoloResults) {
      String label = result['tag'];
      labelCounts[label] = (labelCounts[label] ?? 0) + 1;
    }
    return labelCounts;
  }

  @override
  void dispose() {
    if (controller.value.isStreamingImages) {
      controller.stopImageStream();
    }
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
          child: CircularProgressIndicator(),
        ),
      );
    }

    Map<String, int> labelCounts = getLabelCounts();

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
                  border: Border.all(width: 2, color: Colors.white),
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
                ),
              ),
            ),
          ),
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: LiveDetectionPage(),
  ));
}
