import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/dl_model_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ModelDetailPage extends StatefulWidget {
  final DLModelModel model;

  const ModelDetailPage({super.key, required this.model});

  @override
  State<ModelDetailPage> createState() => _ModelDetailPageState();
}

class _ModelDetailPageState extends State<ModelDetailPage> {
  File? _image;
  String? _predictedLabel;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _predictedLabel = null;
      });

      // Simulate classification
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _predictedLabel = "Apical 4-chamber view"; // Simulated result
        });
      });
    }
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('saved_models') ?? [];
    setState(() {
      isFavorite = saved.contains(widget.model.name);
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('saved_models') ?? [];

    if (isFavorite) {
      saved.remove(widget.model.name);
    } else {
      saved.add(widget.model.name);
      // Save full object as well
      prefs.setString('model_${widget.model.name}', jsonEncode(widget.model.toJson()));
    }

    await prefs.setStringList('saved_models', saved);
    setState(() => isFavorite = !isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;

    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: _toggleFavorite,
          ),
        ],
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Same UI as before ...
          ],
        ),
      ),
    );
  }
}
