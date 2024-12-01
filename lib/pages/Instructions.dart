import 'package:flutter/material.dart';

class HelpFeedback extends StatefulWidget {
  const HelpFeedback({super.key});

  @override
  State<HelpFeedback> createState() => _HelpFeedbackState();
}

class _HelpFeedbackState extends State<HelpFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Manual'),
        backgroundColor: const Color.fromARGB(255, 191, 255, 139),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'How to use the App',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                  selectionColor: Colors.amber,
                ),
              ),
              Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/usermanual/AppLogo.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '1. First, Open the SeedScan App.',
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
                      'assets/images/usermanual/auth.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '2. Press the "Authenticate" button and proceed with fingerprint.',
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
                      'assets/images/usermanual/I1.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '3. You are now at the homescreen.',
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
                      'assets/images/usermanual/I5.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '4. Navigate to the scanner screen. you can now choose what feature you want to use. (Corn Viability Detection or Corn Type Detection).',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Options',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildHorizontalCard(
                        'assets/images/usermanual/I7.jpg',
                        'Corn Viability Detection Feature',
                        '5.1. In Scanner Screen If You choose the Corn Viability Detection You can start/stop detection by pressing the button below, and save the readings in the History by pressing the "Save History" button at the top Left and view the readings by pressing the view history in the top right most.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/usermanual/I8.jpg',
                        'Corn Type Detection Feature',
                        '5.2. In Scanner Screen If You choose the Corn Type Detection You can start/stop detection by pressing the button below, and save the readings in the History by pressing the "Save History" button at the top Left and view the readings by pressing the view history in the top right most.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/usermanual/I2.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '6. You can View history by navigating to the History Screen in navigation bar.',
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
                      'assets/images/usermanual/I11.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '7. You can now view details of your readings and when you click the specific readings you can View the Graphical data base on the detections.',
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
                      'assets/images/usermanual/I3.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '8. In History screen you have the option to delete specific reading by pressing the delete icon beside each reading history.',
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
                      'assets/images/usermanual/I4.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '9. But if you want to delete all the readings in the history you can click the upper right most delete icon to delete all the history in the history screen.',
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
                      'assets/images/usermanual/I9.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '10. For the Estimated Harvest Calculator you can enter manually the number of viable seeds detected, pressed the "Calculate Harvest" button and the calculator will provide number of estimated corn harvest.',
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
                      'assets/images/usermanual/I10.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '11. In Settings you can select "About app", "User Manual", "About Dev" and "Special Thanks".',
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
                      'assets/images/instruction3.jpeg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '12. All Done',
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

  Widget _buildHorizontalCard(
      String imagePath, String title, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(right: 12), // Add spacing between cards
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(126, 158, 158, 158), // Set the border color
            width: 1, // Set the border width
          ),
          borderRadius: BorderRadius.circular(
              10), // Optional: Adds rounded corners to the border
        ),
        child: SizedBox(
          width: 320, // Set a consistent width for all cards
          height: 520, // Set the card height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 300, // Adjust image height for better fitting
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
