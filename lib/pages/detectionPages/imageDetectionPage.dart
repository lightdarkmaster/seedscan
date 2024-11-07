import 'package:flutter/material.dart';


class ImageDetectionPage extends StatelessWidget {
  const ImageDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detection'),
      ),
      body: const Center(
        child: Text(
          'This is the Image Detection Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
