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
        preferredSize: const Size.fromHeight(65.0), // Set your desired height here
        child: AppBar(
          title: const Text(
            "Image Options",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true, // Centers the title in the AppBar
          backgroundColor: const Color.fromARGB(255, 191, 255, 139),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCard(
                label: 'Corn Viability Detection',
                imagePath: 'assets/images/handCorn.png',
                buttonLabel: 'Start Detection',
                onPressed: () {
                  print('Option 1 button pressed');
                },
                borderColor: Colors.green,
                buttonBorderColor: Colors.black,
                onInfoPressed: () {
                  _showInfoDialog(
                    context,
                    title: 'Corn Viability Detection',
                    message: 'Provides a feature to assess the viability of corn seeds by analyzing their visual characteristics.',
                  );
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
                borderColor: Colors.blue,
                buttonBorderColor: Colors.black,
                onInfoPressed: () {
                  _showInfoDialog(
                    context,
                    title: 'Corn Type Detection',
                    message: 'Identifies the type of corn based on its unique features to assist in classification and analysis.',
                  );
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
    required Color borderColor,
    required Color buttonBorderColor,
    required VoidCallback onInfoPressed,
  }) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9, // Card width is 90% of screen width
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor, width: 1), // Card border color
          ),
          child: Stack(
            alignment: Alignment.center, // Aligns all content to the center
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
                  crossAxisAlignment: CrossAxisAlignment.center, // Centers content horizontally
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
                      height: 150, // Height of the image
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        side: BorderSide(
                            color: buttonBorderColor, width: 1), // Button border color
                      ),
                      child: Text(buttonLabel),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                  ),
                  onPressed: onInfoPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, {required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
