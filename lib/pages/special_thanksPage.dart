import 'package:flutter/material.dart';

class SpecialThankspage extends StatefulWidget {
  const SpecialThankspage({super.key});

  @override
  State<SpecialThankspage> createState() => _SpecialThankspageState();
}

class _SpecialThankspageState extends State<SpecialThankspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Thanks'),
        backgroundColor: const Color.fromARGB(255, 191, 255, 139),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              'assets/images/DA.jpg',
              'Department of Agriculture (Babatngon)',
              'Thank you for your invaluable guidance and support throughout this project.',
            ),
            _buildCard(
              'assets/images/DA2.jpg',
              'Person 2',
              'Your contributions and encouragement have been instrumental in our success.',
            ),
            _buildCard(
              'assets/images/DA3.jpg',
              'Person 3',
              'We deeply appreciate your dedication and assistance in making this project a reality.',
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a card with an image, title, and description
  Widget _buildCard(String imagePath, String title, String description) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Space between cards
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image inside the card
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              imagePath,
              width: double.infinity, // Stretch image across the card width
              height: 150.0, // Set image height
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0), // Space between image and content

          // Title of the card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),

          // Description of the card
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SpecialThankspage(),
  ));
}
