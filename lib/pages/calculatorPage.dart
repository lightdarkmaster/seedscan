import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _controller = TextEditingController();
  double? _result;

  void _calculate() {
    final input = double.tryParse(_controller.text);
    if (input != null) {
      setState(() {
        _result = input * 4.2;
      });
    } else {
      setState(() {
        _result = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: 520, // Adjust the height as per your requirement
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Add image on top of the card
                    Image.asset(
                      'assets/images/calculator.gif', // Replace with your image path
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Number of Viable Seeds:",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, // Set text color to black
                        backgroundColor: const Color.fromARGB(255, 191, 255, 139), // Background color
                      ),
                      child: const Text("Calculate Harvest"),
                    ),
                    const SizedBox(height: 20),
                    if (_result != null)
                      Text(
                        "Expected Harvest: ${_result!.toStringAsFixed(2)} corns",
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.blue, // Set the result color to blue
                        ),
                      ),
                    if (_result == null && _controller.text.isNotEmpty)
                      const Text(
                        "Invalid input. Please enter a valid number.",
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
