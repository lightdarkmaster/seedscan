import 'package:flutter/material.dart';

class AboutDevPage extends StatefulWidget {
  const AboutDevPage({super.key});

  @override
  State<AboutDevPage> createState() => _AboutDevPageState();
}

class _AboutDevPageState extends State<AboutDevPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Developer'),
        backgroundColor: const Color.fromARGB(255, 191, 255, 139),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 4, // Total number of cards
          itemBuilder: (context, index) {
            return _buildCard(
              'assets/images/card${index + 1}.jpg', // Replace with your image paths
              'Card Title $index',
              _getCardContent(index), // Different content for each card
            );
          },
        ),
      ),
    );
  }

  // Function to build a card with an image, title, and description
  Widget _buildCard(String imagePath, String title, String content) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Space between cards
      child: Column(
        children: [
          // Image inside the card
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              width: double.infinity, // Make the image stretch across the width
              height: 150.0, // Adjust the image height as needed
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0), // Space between image and content

          // Title of the card
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),

          // Content below the title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Function to return content for each card dynamically
  String _getCardContent(int index) {
    switch (index) {
      case 0:
        return 'This is the first card description. It explains the basics of the developer.';
      case 1:
        return 'This is the second card. Here you can read about the skills and experience.';
      case 2:
        return 'This is the third card. It highlights the developer\'s achievements and contributions.';
      case 3:
        return 'The fourth card provides additional information on future projects and goals.';
      default:
        return 'Card content not available.';
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: AboutDevPage(),
  ));
}
