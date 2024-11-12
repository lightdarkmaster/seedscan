import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:async';
import 'dart:io';

class ImageCornViability extends StatefulWidget {
  const ImageCornViability({Key? key}) : super(key: key);

  @override
  _ImageCornViabilityWidgetState createState() =>
      _ImageCornViabilityWidgetState();
}

class _ImageCornViabilityWidgetState extends State<ImageCornViability> {
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  List<dynamic>? _recognitions1;
  List<dynamic>? _recognitions2; // Recognitions for the second model
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _initializeTflite();
  }

  Future<void> _initializeTflite() async {
    // Load the model and labels
    await Tflite.loadModel(
      model: "assets/models/cornViability.tflite",
      labels: "assets/models/viabilityLabel.txt",
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
        _recognitions1 = null; // Clear previous recognitions
        _recognitions2 = null; // Clear previous recognitions
        _isLoading = true;
      });
      await _processImage();
    }
  }

  Future<void> _captureImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
        _recognitions1 = null; // Clear previous recognitions
        _recognitions2 = null; // Clear previous recognitions
        _isLoading = true;
      });
      await _processImage();
    }
  }

  Future<void> _processImage() async {
    if (_pickedImage != null) {
      final List<dynamic>? recognitions1 = await Tflite.runModelOnImage(
        path: _pickedImage!.path,
        numResults: 5,
        threshold: 0.5,
      );

      final List<dynamic>? recognitions2 = await Tflite.runModelOnImage(
        path: _pickedImage!.path,
        numResults: 5,
        threshold: 0.5,
      );

      // Update the recognitions
      setState(() {
        _recognitions1 = recognitions1;
        _recognitions2 = recognitions2;
        _isLoading = false;
      });
    }
  }

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            if (!_isLoading && _pickedImage != null)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Image.file(
                  File(_pickedImage!.path),
                  fit: BoxFit.cover,
                ),
              )
            else if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo),
              label: const Text(
                "Select from Gallery",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _captureImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text(
                "Take Photo",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Display combined recognitions if available
            if (_recognitions1 != null && _recognitions2 != null)
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        "Results:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 86, 54, 244),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _recognitions2!
                            .map(
                              (recognition) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Corn Seed Label: ${recognition['label']}",
                                    style: TextStyle(
                                      color: recognition['label'] ==
                                              'Non-Viable'
                                          ? Colors.red // Red for Non-Viable
                                          : recognition['label'] == 'Viable'
                                              ? Colors.green // Green for Viable
                                              : Colors
                                                  .black, // Black for Undefined
                                    ),
                                  ),
                                  Text(
                                    "Confidence Level: ${(recognition['confidence'] * 100).toStringAsFixed(2)}%",
                                    style: TextStyle(
                                      color: recognition['label'] ==
                                              'Non-Viable'
                                          ? Colors.red // Red for Non-Viable
                                          : recognition['label'] == 'Viable'
                                              ? Colors.green // Green for Viable
                                              : Colors
                                                  .black, // Black for Undefined
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Details:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 86, 54, 244),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _recognitions1!
                            .map(
                              (recognition) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Corn Seed Label: ${recognition['label']}"),
                                  Text(
                                    "Confidence Level: ${(recognition['confidence'] * 100).toStringAsFixed(2)}%",
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose TFLite resources
    Tflite.close();
    super.dispose();
  }
}

void main() {
  runApp(const MaterialApp(
    home: ImageCornViability(),
  ));
}
