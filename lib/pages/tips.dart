import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo1.png',
            height: 30,
          ),
        ),
        title: Text('Tips'),
        backgroundColor: const Color.fromARGB(
            255, 191, 255, 139), // Set button color to black
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  // Image beside the card
                  Container(
                    margin: const EdgeInsets.only(right: 8), // Add some spacing
                    height: 100, // Set desired height
                    width: 100, // Set desired width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/tip.png'), // Your image path
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Card with text
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Set the border color
                          width: 1.0, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // Optional: Rounded corners
                      ),
                      child: Card(
                        color: Color.fromARGB(241, 255, 225, 2),
                        elevation: 5,
                        margin: EdgeInsets
                            .zero, // Remove card margin for better alignment
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tips for better detections:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      4), // Add spacing between title and text
                              Text(
                                'This is a set of tips for running good results while running the inference.',
                                style: TextStyle(fontSize: 12),
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

            // Card 1
            const SizedBox(
              height: 25,
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200, // Set the desired height
                    width: double.infinity, // Make it span the card's width
                    child: Image.asset(
                      'assets/images/tip1.jpg',
                      fit: BoxFit.contain, // Adjust the image's aspect ratio
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tip 1: Focus on the Subjects',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Ensure that while using any detection stream, be sure to focus on the subject to avoid mislabeled detection.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Card 2
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200, // Set the desired height
                    width: double.infinity, // Make it span the card's width
                    child: Image.asset(
                      'assets/images/tip2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tip 2: Balance lighting conditions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Be in a place with well-balanced lighting conditions (not too bright/not too dim) for better readings of the model and better performance.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Card 3
            Card(
              elevation: 10,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200, // Set the desired height
                    width: double.infinity, // Make it span the card's width
                    child: Image.asset(
                      'assets/images/tip3.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tip 3: Maintain Stability',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Avoid moving your phone as much as possible to make the detection more stable.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

//need to capture the widget camera