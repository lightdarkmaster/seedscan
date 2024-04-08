import 'package:flutter/material.dart';

class DiseaseTypes extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DiseaseTypes({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Corn Seeds Types',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExpansionTile(
                title: Text(
                  'Pure Corn Seeds',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.justify,
                ),
                children: [
                  Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/pure.jpg',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Pure corn seeds are meticulously cultivated kernels free from cross-pollination or contamination, ensuring genetic uniformity and consistency in traits such as yield potential, disease resistance, and agronomic characteristics. These seeds undergo rigorous testing and production processes to maintain their purity, making them sought after by farmers aiming for reliable crop performance and optimal harvest outcomes. With their assurance of uniformity and stability, pure corn seeds are integral to sustaining specific corn varieties and maximizing agricultural productivity.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                       ExpansionTile(
                title: Text(
                  'Broken Corn Seeds',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.justify,
                ),
                children: [
                  Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/broken.jpg',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Broken corn seeds are kernels that have suffered damage or fractures during harvesting, processing, or storage, leading to cracks, splits, or fragmented pieces. This damage compromises their quality and viability for planting or consumption, often resulting in reduced germination rates and increased susceptibility to pests and diseases. In agricultural contexts, broken corn seeds are typically considered inferior, leading to their disposal or repurposing for lower-grade products such as animal feed or industrial uses. Proper handling and storage practices are essential to minimize breakage and preserve the integrity of corn seeds for optimal agricultural use.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                       ExpansionTile(
                title: Text(
                  'Discolored Corn Seeds',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.justify,
                ),
                children: [
                  Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/discolored.png',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Discolored corn seeds exhibit abnormal coloring or staining, often due to environmental factors, fungal infections, or improper storage conditions. These seeds may display shades of brown, black, gray, or other hues indicative of decay, mold, or fungal growth, compromising their quality and viability for planting. Discoloration negatively impacts germination rates and overall crop health, necessitating careful selection and treatment by farmers and seed producers. Measures such as discarding discolored seeds or applying fungicides help mitigate fungal infections and prevent further deterioration, ensuring the preservation of high-quality, uniformly colored seeds essential for optimal crop performance and yield.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  'Silkcut',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.justify,
                ),
                children: [
                  Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/silkcut.png',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Silkcut corn seeds, also known as silage or forage corn seeds, are specialized varieties cultivated for their high fiber and moisture content, making them ideal for livestock feed. These seeds are selected for their tall stalks and large leaves, which contribute to a higher yield of plant material suitable for ensiling or chopping into silage. Harvested typically at the milk or dough stage when the kernels are developing, silkcut corn seeds are characterized by the emergence of silks, indicating the onset of pollination. Silage produced from silkcut corn seeds is commonly used to feed dairy cattle, beef cattle, and other livestock, providing essential nutrients for growth and maintenance while maximizing agricultural productivity.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
