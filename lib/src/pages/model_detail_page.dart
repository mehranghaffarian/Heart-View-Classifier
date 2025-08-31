import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/dl_model.dart';
import 'package:hvc_app/src/helper/models_database_helper.dart';
import 'package:hvc_app/src/pages/home_page.dart';
import 'package:hvc_app/src/pages/saved_page.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';
import 'package:hvc_app/src/widgets/bottom_navigation_bar.dart';
import 'package:hvc_app/src/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ModelDetailPage extends StatefulWidget {
  final DLModel model;

  const ModelDetailPage({super.key, required this.model});

  @override
  State<ModelDetailPage> createState() => _ModelDetailPageState();
}

class _ModelDetailPageState extends State<ModelDetailPage> {
  late Interpreter _interpreter;
  File? _image;
  String? _predictedLabel;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    _interpreter = await Interpreter.fromAsset(
        'assets/models/${widget.model.name}.tflite');
  }

  Future<void> _pickAndClassifyImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _predictedLabel = null;
      });

      // Read raw bytes
      final raw = await File(pickedFile.path).readAsBytes();
      img.Image? image = img.decodeImage(raw);

      if (image == null) return;

      // ---- STEP 1: Crop like in training (50 top/bottom, 100 left/right) ----
      final cropped = img.copyCrop(
        image,
        x: 100,
        y: 50,
        width: image.width - 200,
        height: image.height - 100,
      );

      // ---- STEP 2: Resize to model input
      List<String> parts = widget.model.inputSize.split('x');
      int width = int.parse(parts[0]);
      int height = int.parse(parts[1]);
      final resized = img.copyResize(cropped, width: 224, height: 224);

      // ---- STEP 3: Normalize pixels to [0,1] ----
      // Prepare input as 4D tensor [1, height, width, 3]
      var input = List.generate(
        1,
        (_) => List.generate(
          height,
          (y) => List.generate(
            width,
            (x) {
              final pixel = resized.getPixel(x, y);
              final r = pixel.r / 255.0;
              final g = pixel.g / 255.0;
              final b = pixel.b / 255.0;
              return [r, g, b]; // 3 channels
            },
          ),
        ),
      );

      // ---- STEP 4: Prepare output (based on number of classes)
      var output = List.filled(1 * 5, 0).reshape([1, 5]);

      // ---- STEP 5: Run inference ----
      _interpreter.run(input, output);

      final labels = ['a2c', 'a3c', 'a4c', 'a5c', 'plax'];
      final prediction = output[0]; // [0.02, 0.05, 0.09, 0.02, 0.82]

      // Find index of max
      int maxIndex = 0;
      double maxValue = prediction[0];
      for (int i = 1; i < prediction.length; i++) {
        if (prediction[i] > maxValue) {
          maxValue = prediction[i];
          maxIndex = i;
        }
      }
      String predictedClass = labels[maxIndex];
      double confidence = prediction[maxIndex];

      setState(() {
        _predictedLabel = predictedClass+prediction.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(
        context,
        LightColor.green,
        2,
        (index) {
          if (index == 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SavedPage()));
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(
              context,
              120,
              LightColor.green,
              LightColor.lightGreen,
              LightColor.darkGreen,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      model.isSaved ? Icons.favorite : Icons.favorite_border,
                      color: model.isSaved ? Colors.red : Colors.grey,
                    ),
                    onPressed: () async {
                      model.isSaved = !model.isSaved;
                      await ModelsDatabaseHelper.instance.update(model);
                      setState(() {}); // Update UI
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    model.description,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Divider(thickness: 1, endIndent: 16, indent: 16),
                  const SizedBox(height: 15),
                  _image != null
                      ? Image.file(_image!,
                          width: 200, height: 200, fit: BoxFit.cover)
                      : const Text('No image selected'),
                  const SizedBox(height: 20),
                  _image == null
                      ? ElevatedButton(
                          onPressed: _pickAndClassifyImage,
                          child: const Text(
                            'Pick Image',
                            style: TextStyle(color: LightColor.green),
                          ),
                        )
                      : _predictedLabel != null
                          ? Text(
                              _predictedLabel!,
                              style:
                                  const TextStyle(color: LightColor.darkGreen),
                            )
                          : ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Classify Image',
                              ),
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
