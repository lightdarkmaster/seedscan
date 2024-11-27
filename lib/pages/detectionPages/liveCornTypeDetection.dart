import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter/material.dart';

class CameraPage2 extends StatefulWidget {
  const CameraPage2({super.key});

  @override
  State<CameraPage2> createState() => _CameraPage2State();
}

class _CameraPage2State extends State<CameraPage2> {
  late List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class YoloVideo2 extends StatefulWidget {
  const YoloVideo2({super.key});

  @override
  State<YoloVideo2> createState() => _YoloVideo2State();
}

class _YoloVideo2State extends State<YoloVideo2> {
  late CameraController controller;
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;

  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  double confidenceThreshold = 0.5;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    List<CameraDescription> cameras = await availableCameras();
    vision = FlutterVision();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();

    await loadYoloModel();

    setState(() {
      isLoaded = true;
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
    if (isDetecting) {
      setState(() {
        isDetecting = false;
        yoloResults.clear();
      });

      // Stop the camera image stream
      await controller.stopImageStream();
    }
  }

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
      bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
      iouThreshold: 0.6,
      confThreshold: 0.60,
      classThreshold: 0.55,
    );

    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
      });
    }
  }

List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
  if (yoloResults.isEmpty || cameraImage == null) return [];

  double factorX = screen.width / cameraImage!.height;
  double factorY = screen.height / cameraImage!.width;

  // Define a color map for specific labels
  Map<String, Color> labelColors = {
    'white lagkitan': Colors.white,
    'sweet corn': Colors.yellow,
  };

  return yoloResults.map((result) {
    double objectX = result["box"][0] * factorX;
    double objectY = result["box"][1] * factorY;
    double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
    double objectHeight = (result["box"][3] - result["box"][1]) * factorY;

    // Determine the color based on the label, default to gray
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
              ),
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
              border: Border.all(color: boxColor, width: 2.0),
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
void dispose() async {
  if (isDetecting) {
    await stopDetection();
  }
  await controller.dispose();
  await vision.closeYoloModel();
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
    home: YoloVideo2(),
  ));
}