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
              'assets/images/4pics2.jpg', // Replace with actual image paths
              _getCardTitle(index), // Title for each card
              _getCardContent(index), // Content for each card
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image inside the card
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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

  // Function to return title for each card dynamically
  String _getCardTitle(int index) {
    switch (index) {
      case 0:
        return 'Introduction';
      case 1:
        return 'Skills & Expertise';
      case 2:
        return 'Achievements';
      case 3:
        return 'Future Goals';
      default:
        return 'Unknown';
    }
  }

  // Function to return content for each card dynamically
  String _getCardContent(int index) {
    switch (index) {
      case 0:
        return 'Learn about the developer\'s background and journey in software development.';
      case 1:
        return 'Discover the various skills, programming languages, and tools mastered by the developer.';
      case 2:
        return 'Read about the developer\'s notable achievements and completed projects.';
      case 3:
        return 'Explore future projects, ambitions, and goals envisioned by the developer.';
      default:
        return 'Content not available.';
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: AboutDevPage(),
  ));
}
