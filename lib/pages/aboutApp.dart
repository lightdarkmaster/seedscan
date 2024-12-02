import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        backgroundColor: const Color.fromARGB(255, 191, 255, 139),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/logo1.png',
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Seedscan',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'This innovative app utilizes Artificial Intelligence (AI) Convolutional Neural Network (CNN) YOLO algorithms to redefine how farmers assess the viability of their corn seeds. With just a simple live stream capture using a smartphone camera, our app analyzes key indicators of seed viability with precision, including germination potential and estimated harvest.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Card(
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/pic6.png',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'By harnessing the power of deep learning, our app provides farmers with instant insights into the quality of their corn seeds, enabling informed decision-making regarding seed selection and cultivation practices.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Card(
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/tip.png',
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Experience the future of agriculture with our Corn Seed Viability App – where state-of-the-art AI meets agricultural innovation to drive productivity and sustainability in the field.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Technology Used: ',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.justify,
                ),
              ),
              // Horizontally scrollable cards
              SizedBox(
                height: 300, // Increase the height for better space management
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildHorizontalCard(
                        'assets/images/flutter.png',
                        'Flutter',
                        'A UI toolkit by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/dart.png',
                        'Dart',
                        'is a client-optimized programming language for building fast, high-performance applications across various platforms.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/yolo.png',
                        'YOLO',
                        'A real-time object detection algorithm that identifies and localizes objects in images or videos with high accuracy and speed.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/python.png',
                        'Python',
                        'A versatile, high-level programming language known for its simplicity, readability, and broad use in web development, data analysis, AI, and more.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/tflite.png',
                        'TensorFlow Lite',
                        'A lightweight, optimized version of TensorFlow designed for deploying machine learning models on mobile and embedded devices.',
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Core Packages Used: ',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.justify,
                ),
              ),
              // Horizontally scrollable cards
              SizedBox(
                height: 300, // Increase the height for better space management
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildHorizontalCard(
                        'assets/images/tfliteFlutter.jpg',
                        'tflite_flutter',
                        'TensorFlow Lite Flutter plugin provides a flexible and fast solution for accessing TensorFlow Lite interpreter and performing inference.',
                      ),
                     _buildHorizontalCard(
                        'assets/images/flutter_vision.png',
                        'flutter_vision',
                        'Flutter Vision is an innovative Flutter library designed for implementing machine learning and computer vision tasks in Flutter applications.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/fingerprint.png',
                        'local_auth',
                        'a flutter packaged that supports local authentication using biometric fingerprint recognitions',
                      ),
                      _buildHorizontalCard(
                        'assets/images/sqlite.png',
                        'sqflite',
                        'SQLite in Flutter is a lightweight, relational database integrated into mobile apps for local storage of structured data.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(
      String imagePath, String title, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(right: 12), // Add spacing between cards
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(126, 158, 158, 158), // Set the border color
            width: 1, // Set the border width
          ),
          borderRadius: BorderRadius.circular(10), // Optional: Adds rounded corners to the border
        ),
        child: SizedBox(
          width: 200, // Set a consistent width for all cards
          height: 350, // Set the card height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 120, // Adjust image height for better fitting
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
