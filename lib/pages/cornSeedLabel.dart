import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:async';
import 'dart:io';

class CornLabel extends StatefulWidget {
  const CornLabel({Key? key}) : super(key: key);

  @override
  _CornLabeltState createState() => _CornLabeltState();
}

class _CornLabeltState extends State<CornLabel> {
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  List<dynamic>? _recognitions;
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
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _pickImageFromGallery2() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
        _recognitions = null; // Clear previous recognitions
        _isLoading = true;
      });
      await _processImage2();
    }
  }

  Future<void> _captureImage2() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
        _recognitions = null; // Clear previous recognitions
        _isLoading = true;
      });
      await _processImage2();
    }
  }

  Future<void> _processImage2() async {
    if (_pickedImage != null) {
      final List<dynamic>? recognitions = await Tflite.runModelOnImage(
        path: _pickedImage!.path,
        numResults: 5,
        threshold: 0.5,
      );

      // Update the recognitions
      setState(() {
        _recognitions = recognitions;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Scan/Upload Seeds Here",
              style: TextStyle(fontSize: 20),
            ),
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
              Center(
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
              onPressed: _pickImageFromGallery2,
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
              onPressed: _captureImage2,
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
            // Display recognitions if available
            if (_recognitions != null)
              Card(
                child: Column(
                  children: _recognitions!
                      .map(
                        (recognition) => ListTile(
                          title: const Text(
                            "Results:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Corn Seed Label: ${recognition['label']}"),
                              Text(
                                "Confidence Level: ${(recognition['confidence'] * 100).toStringAsFixed(2)}%",
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
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

  
  void init() {
    _initializeTflite();
  }
}

void main() {
  runApp(const MaterialApp(
    home: CornLabel(),
  ));
}