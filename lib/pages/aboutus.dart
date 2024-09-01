import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(65.0), // Set your desired height here
        child: AppBar(
          title: const Text(
            "Seed Scan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 191, 255, 139),
        ),
      ),
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
                      'assets/images/maisbook.jpeg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'About MaisBook',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'MaisBook is an advanced analytics tool designed to provide farmers with actionable insights into their maize (corn) cultivation practices. By leveraging cutting-edge data analytics algorithms, MaisBook helps farmers optimize their planting strategies, predict crop yields, and identify potential risks or issues in their fields.',
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
                      'assets/images/pic5.jpeg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'MaisBook is an advanced analytics tool designed to provide farmers with actionable insights into their maize (corn) cultivation practices. By leveraging cutting-edge data analytics algorithms, MaisBook helps farmers optimize their planting strategies, predict crop yields, and identify potential risks or issues in their fields.',
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
