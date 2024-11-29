import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                            'The Philippines harvests tons of corn each year. It’s the SECOND MOST IMPORTANT STAPLE CROP IN THE COUNTRY, only second to rice. Surprisingly, though, only a small chunk of Philippine corn lands on our tables. The majority of it is used for livestock and manufacturing. Still, we have enough of it in our diets to know that there’s more than one kind of it—and we’re not just talking about white or yellow. (Though Philippine corn is generally categorized into the two.)',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/sweetCorn.jpg', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Sweet Corn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Sweet corn refers to long, yellow ears of corn, often also called Japanese sweet corn*, sugar corn, or table corn. These are long ears, with almost bright green husks and very yellow kernels. You’ll often see these sold streetside or sold in mall stalls boiled and shredded with margarine and cheese powder. They’re also commonly sold in supermarkets. True to its name, sweet corn is sweet and juicy. It can be added to soups, as well as desserts such as mais con yelo and corn pudding . You can also use them in ginataang MAIS or make them into sweet tamales.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/wildVioletCorn.jpg', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Wild Violet Corn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Wild violet corn is a rare Philippine corn variety characterized by a mix of white and purple kernels. It’s sticky, waxy, and slightly sweet when harvested. And you can serve it boiled or roasted.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/whiteLagkitan.jpg', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'White Lagkitan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'White lagkitan (also known as waxy corn or glutinous corn) is one of the most common varieties harvested in the country. You’ll find it in many corn-producing regions, where it’s available either fresh, dried, or canned. Dried lagkitan (hominy) can be ground into a fine powder such as cornmeal, grits, or cornflour. But we usually enjoy it as binatog or kornik.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/visayanWhiteCorn.png', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Visayan White Corn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Visayan white corn (tinigib) is a variety of Philippine corn generally found in the Cebu region. It boasts a low glycemic index, making it slower to digest resulting in a more gradual release of glucose in the body. This, plus the fact that it tastes like rice, makes it a common rice substitute. People often use tinigib to make maja blanca, pintos or binaki (like corn tamales), and SUAM NA MAIS (aka ginarep or dinengdeng na mais; a fresh corn soup with spinach or malunggay). You can also roast Visayan white corn to make a drink called kapeng mais, which surprisingly tastes a bit like coffee.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/purpleCorn.jpg', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Purple Corn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Purple corn is common in the Andes region of South America. A few years ago, it was introduced to the Philippines, becoming a hit for its high antioxidant content. When harvested, purple corn is sticky and sweet. It’s typically soaked in boiling water and used as a food coloring. But it’s also famously used to make Peruvian CHICHA MORADA. This corn drink is specifically made using purple corn with a combo of spices like cinnamon and cloves, served with lime or lemon slices.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/youngCorn.jpg', // Path to local image asset
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Young Corn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Young corn refers to mais harvested at its early stage, while the stalks are still young and immature. Their mildly sweet flavor and snappy texture make them an indispensable ingredient for chop suey. You can also simply eat them steamed or roasted with butter, stir-fried into rice or noodles, or added into soups or stews.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
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