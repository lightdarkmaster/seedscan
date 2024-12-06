import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: const Color.fromARGB(255, 191, 255, 139),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          FAQCard(
            imagePath: 'assets/images/handCorn.png',
            question: 'Is the corn seeds still viable after 6 months?',
            answer: 'Yes, corn seeds can germinate after 6 months if they were stored properly in a cool, dry, and dark place with low humidity. Under ideal conditions, corn seeds remain viable for 1-2 years. Testing their germination rate before planting is recommended to ensure viability.',
          ),
          FAQCard(
            imagePath: 'assets/images/types.jpg',
            question: 'What are the two types of Corn Seeds?',
            answer: 'There are two main types of corn seeds: hybrid seeds and open-pollinated seeds. Hybrid seeds are selectively bred for specific traits such as high yield, disease resistance, and uniformity, making them popular for commercial farming. However, they do not produce true-to-type seeds, meaning farmers cannot save them for replanting. Open-pollinated seeds, on the other hand, are naturally pollinated and can be saved and replanted year after year, maintaining their genetic characteristics. These are often favored by small-scale farmers and gardeners for their sustainability and diversity.',
          ),
          FAQCard(
            imagePath: 'assets/images/seeds.png',
            question: 'What are the characteristics of healthy corn seeds?',
            answer: 'Healthy corn seeds are plump, well-filled, and uniform in size, reflecting proper development and viability. They have a vibrant, natural color and a smooth, intact seed coat, free from cracks or abrasions. These seeds should be dry to the touch, stored with low moisture content, and free from mold, rot, or insect damage. Additionally, they are clean, free from dirt or debris, and emit no unpleasant odors. Healthy seeds typically exhibit a high germination rate and, if treated, may have a protective coating for enhanced resistance to pests and improved performance. Proper storage and handling ensure their quality and longevity.',
          ),
        ],
      ),
    );
  }
}

class FAQCard extends StatefulWidget {
  final String imagePath;
  final String question;
  final String answer;

  const FAQCard({
    super.key,
    required this.imagePath,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.contain,
              height: 150.0,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.question,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  _isExpanded ? widget.answer : '${widget.answer.substring(0, 50)}...',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(_isExpanded ? 'Show Less' : 'Read More', style: TextStyle(color: Colors.green),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
