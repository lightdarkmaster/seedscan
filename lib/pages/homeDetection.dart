import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/imageDetectionPage.dart';
import 'package:seedscan2/pages/detectionPages/liveDetectionPage.dart';

class HomeDetection extends StatefulWidget {
  const HomeDetection({super.key});

  @override
  State<HomeDetection> createState() => HomeDetectionState();
}

class HomeDetectionState extends State<HomeDetection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Detection'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the LiveDetectionPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LiveDetectionPage()),
                );
              },
              child: const Text('Detect Live'),
            ),
            const SizedBox(height: 20), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to the ImageDetectionPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImageDetectionPage()),
                );
              },
              child: const Text('Detect Image'),
            ),
          ],
        ),
      ),
    );
  }
}
