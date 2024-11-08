import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/liveDetectionPage.dart';
import 'package:seedscan2/pages/detectionPages/imageDetectionPage.dart';

class HomeDetection extends StatefulWidget {
  const HomeDetection({super.key});

  @override
  State<HomeDetection> createState() => HomeDetectionState();
}

class HomeDetectionState extends State<HomeDetection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Allows scrolling if content overflows
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // Gap space between cards
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9, // 90% of the screen width
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue, // Border color
                      width: 1,          // Border thickness
                    ),
                    borderRadius: BorderRadius.circular(8), // Optional rounded corners
                  ),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.all(0), // Remove margin to align with border
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            'Live Detection',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150, // Adjust height based on card size
                            child: Image.asset(
                              'assets/gifs/liveRecorder.gif', // Replace with your GIF path
                              fit: BoxFit.contain, // Ensures the GIF fits within available space
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const YoloVideo()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 191, 255, 139), // Button background color
                              foregroundColor: Colors.black, // Button text color
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              side: const BorderSide(
                                color: Colors.blue, // Border color
                                width: 1,          // Border width
                              ),
                            ),
                            child: const Text('Detect Live'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Gap space between cards
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9, // 90% of the screen width
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red, // Border color
                      width: 1,           // Border thickness
                    ),
                    borderRadius: BorderRadius.circular(8), // Optional rounded corners
                  ),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.all(0), // Remove margin to align with border
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            'Image Detection',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150, // Adjust height based on card size
                            child: Image.asset(
                              'assets/gifs/camera.gif',
                              fit: BoxFit.contain, // Ensures the GIF fits within available space
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ImageDetectionPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 191, 255, 139), // Button background color
                              foregroundColor: Colors.black, // Button text color
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              side: const BorderSide(
                                color: Colors.red, // Border color
                                width: 1,          // Border width
                              ),
                            ),
                            child: const Text('Detect Image'),
                          ),
                        ],
                      ),
                    ),
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
