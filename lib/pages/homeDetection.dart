import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/liveDetectionPage.dart';
import 'package:seedscan2/pages/detectionPages/imageDetectionPage.dart';

class HomeDetection extends StatefulWidget {
  const HomeDetection({super.key});

  @override
  State<HomeDetection> createState() => HomeDetectionState();
}

class HomeDetectionState extends State<HomeDetection> {
  void _showInfoDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              _buildCard(
                context,
                title: 'Live Detection',
                imagePath: 'assets/gifs/liveRecorder.gif',
                buttonLabel: 'Detect Live',
                buttonColor: Colors.blue,
                borderColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const YoloVideo()),
                  );
                },
                infoTitle: 'Live Detection Info',
                infoMessage: 'Live detection allows real-time corn seeds viability detection using the device camera.',
              ),
              const SizedBox(height: 40),
              _buildCard(
                context,
                title: 'Image Detection',
                imagePath: 'assets/gifs/camera.gif',
                buttonLabel: 'Detect Image',
                buttonColor: Colors.red,
                borderColor: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ImageDetectionPage()),
                  );
                },
                infoTitle: 'Image Detection Info',
                infoMessage: 'Image detection allows analyzing static image  for corn seeds viability detection.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String imagePath,
    required String buttonLabel,
    required Color buttonColor,
    required Color borderColor,
    required VoidCallback onPressed,
    required String infoTitle,
    required String infoMessage,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Card(
          color: const Color.fromARGB(209, 255, 255, 255),
          elevation: 5,
          margin: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Adjusts column height to its children
                  crossAxisAlignment: CrossAxisAlignment.center, // Centers content horizontally
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: borderColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        height: 150,
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 191, 255, 139),
                          foregroundColor: borderColor,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          side: BorderSide(color: borderColor, width: 1),
                        ),
                        child: Text(buttonLabel),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  icon: const Icon(Icons.info, color: Colors.grey),
                  onPressed: () => _showInfoDialog(context, infoTitle, infoMessage),
                  tooltip: 'More Info',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
