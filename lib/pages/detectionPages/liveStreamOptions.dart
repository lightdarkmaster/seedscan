import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/corn_type_stream.dart';
import 'package:seedscan2/pages/detectionPages/liveViabilityDetectionPage.dart';

class LiveStreamOptions extends StatefulWidget {
  const LiveStreamOptions({super.key});

  @override
  State<LiveStreamOptions> createState() => _LiveStreamOptionsState();
}

class _LiveStreamOptionsState extends State<LiveStreamOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCard(
                context,
                title: 'Corn Viability Detection',
                imagePath: 'assets/gifs/CornType.gif',
                buttonLabel: 'Start Stream',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const YoloVideo(),
                    ),
                  );
                },
                borderColor: Colors.green,
                buttonBorderColor: Colors.black,
                onInfoPressed: () {
                  _showInfoDialog(context, 'Corn Viability Detection Information',
                      'This feature detects the viability of corn seeds.');
                },
              ),
              const SizedBox(height: 20), // Spacing between cards
              _buildCard(
                context,
                title: 'Corn Type Detection',
                imagePath: 'assets/gifs/LiveDemo.gif',
                buttonLabel: 'Start Stream',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const YoloVideo3(),//YoloVideo2
                    ),
                  );
                },
                borderColor: Colors.blue,
                buttonBorderColor: Colors.black,
                onInfoPressed: () {
                  _showInfoDialog(context, 'Corn Type Detection Information',
                      'This feature detects types of corn seeds.');
                },
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
    required VoidCallback onPressed,
    required Color borderColor,
    required Color buttonBorderColor,
    required VoidCallback onInfoPressed,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: 2), // Card border color
      ),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150, // Adjust as needed
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 191, 255, 139),
                      foregroundColor: Colors.black,
                      padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      side: BorderSide(color: buttonBorderColor, width: 1), // Button border color
                    ),
                    child: Text(buttonLabel),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.info, color: Colors.grey),
              onPressed: onInfoPressed,
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close',style: TextStyle(color: Colors.black),),
            ),
          ],
        );
      },
    );
  }
}
