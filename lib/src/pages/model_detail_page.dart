import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/dl_model.dart';
import 'package:hvc_app/src/helper/models_database_helper.dart';
import 'package:hvc_app/src/pages/home_page.dart';
import 'package:hvc_app/src/pages/saved_page.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';
import 'package:hvc_app/src/widgets/bottom_navigation_bar.dart';
import 'package:hvc_app/src/widgets/header.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ModelDetailPage extends StatefulWidget {
  final DLModel model;

  const ModelDetailPage({super.key, required this.model});

  @override
  State<ModelDetailPage> createState() => _ModelDetailPageState();
}

class _ModelDetailPageState extends State<ModelDetailPage> {
  File? _image;
  String? _predictedLabel;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _predictedLabel = null;
      });

      // Simulate classification
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _predictedLabel = "Apical 4-chamber view"; // Simulated result
        });
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
                          onPressed: _pickImage,
                          child: const Text(
                            'Pick Image',
                            style: TextStyle(color: LightColor.green),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: (){},
                          child: const Text(
                            'Classify Image',
                            style: TextStyle(color: LightColor.darkGreen),
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
