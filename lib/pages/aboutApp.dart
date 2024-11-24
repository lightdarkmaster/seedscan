import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/ai.jpg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'About This App',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'This innovative app utilizes AI CNN algorithms and YOLO to redefine how farmers assess the viability of their corn seeds. With just a simple live stream capture using a smartphone camera, our app analyzes key indicators of seed viability with unmatched precision, including germination potential and overall health.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/pic4.jpeg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'By harnessing the power of deep learning, our app provides farmers with instant insights into the quality of their corn seeds, enabling informed decision-making regarding seed selection and cultivation practices.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/pic6.png',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Experience the future of agriculture with our Corn Seed Viability App – where state-of-the-art AI meets agricultural innovation to drive productivity and sustainability in the field.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
