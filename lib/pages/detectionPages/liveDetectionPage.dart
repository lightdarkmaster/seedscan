import 'package:flutter/material.dart';

class LiveDetectionPage extends StatelessWidget {
  const LiveDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Detection'),
      ),
      body: const Center(
        child: Text(
          'This is the Live Detection Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}