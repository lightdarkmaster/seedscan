import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Introduction',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/pic1.png', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Corn (Zea Mays) pertains to the botanical family Gramineae or Panacea, making it a member of the grass family. It boasts the highest per-day productivity among crops and holds the distinction of being one of the earliest cultivated plants in history (Sardar, 2016). In the Philippines, corn assumes a pivotal role in attaining food self-sufficiency, occupying the second most important position among crops (Gargasin, 2018). A significant proportion, amounting to one-third, of Filipino farmers heavily rely on corn as their principal means of livelihood (Biñas, 2021). Given the substantial reliance of numerous farmers on corn production, gaining insights into its viability is of paramount importance.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/pic2.jpg', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Soilborne pathogens may attack seeds and seedlings both before and after plant emergence, as well as the roots and mesocotyl of emerging or established plants.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/corn.png', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'In consideration of the circumstances, the proponents aim to propose “SeedScan: A Sweet Corn Viability Assessment Using Image Recognition.” This system is a mobile application that aims to assess the viability of a corn seed. Despite the fact that previous studies that have similar purposes exist, the proponents aim to cover all varieties of corn that are common in the Philippines, namely sweet corn, wild violet corn, white lagkitan, Visayan white corn, purple, and young corn, as well as deploy the system as a mobile application for convenient access by the general public. While the other studies used Artificial Neural Networks (ANN) and deep Convolutional Neural Networks (DCNN), which have been mentioned earlier in the study, the proponents will use Convolutional Neural Networks (CNN) to assess the corn seed viability. ',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add more cards here as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//need to optimize this app..