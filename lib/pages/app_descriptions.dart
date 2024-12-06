import 'package:flutter/material.dart';
import 'package:seedscan2/pages/Instructions.dart';
import 'package:seedscan2/pages/aboutApp.dart';
import 'package:seedscan2/pages/authenticate.dart';
import 'package:seedscan2/pages/faq.dart';
import 'package:seedscan2/pages/tips.dart';

class AppDescriptions extends StatelessWidget {
  const AppDescriptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grid of cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 cards per row
                crossAxisSpacing: 16.0, // Spacing between cards
                mainAxisSpacing: 16.0, // Spacing between cards vertically
                children: [
                  _buildCard(context, 'assets/icons/mobileApp.png', 'About App', AboutApp()),
                  _buildCard(context, 'assets/images/manual.png', 'User Manual', HelpFeedback()),
                  _buildCard(context, 'assets/images/tipLogo.png', 'Tips', TipsPage()),
                  _buildCard(context, 'assets/images/faq.png', 'FAQ', FAQPage()),
                ],
              ),
            ),
            // Logout Button below the cards
            Padding(
              padding: const EdgeInsets.only(top: 16.0), // Space above the button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AuthenticateBiometric()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 191, 255, 139),// Set button color to black
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String imagePath, String label, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        // Navigate to the next page when the card is clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50.0, // Adjust the size of the logo
              height: 50.0, // Adjust the size of the logo
            ),
            const SizedBox(height: 8.0), // Space between logo and label
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AppDescriptions(),
  ));
}
