import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(127, 245, 193, 255),
        child: const Center(child: Text("Homepage")));
  }
}
