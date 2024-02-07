import 'package:flutter/material.dart';

class SafetyWidget extends StatelessWidget {
  const SafetyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(127, 245, 193, 255),
        child: const Center(
          child: Text("Diagnose Page"),
        ));
  }
}
