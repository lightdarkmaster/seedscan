import 'package:flutter/material.dart';

class ImageOptions extends StatefulWidget {
  const ImageOptions({super.key});

  @override
  State<ImageOptions> createState() => _ImageOptionsState();
}

class _ImageOptionsState extends State<ImageOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(65.0), // Set your desired height here
        child: AppBar(
          title: const Text(
            "Image Options",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 191, 255, 139),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCard(
                label: 'Corn Viability Detection',
                imagePath: 'assets/images/handCorn.png',
                buttonLabel: 'Start Detection',
                onPressed: () {
                  print('Option 1 button pressed');
                },
              ),
              const SizedBox(height: 20), // Space between cards
              _buildCard(
                label: 'Corn Type Detection',
                imagePath: 'assets/images/cornSeedsDamo.png',
                buttonLabel: 'Start Detection',
                onPressed: () {
                  print('Option 2 button pressed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String label,
    required String imagePath,
    required String buttonLabel,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150, // Height of the GIF
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
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: Text(buttonLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
