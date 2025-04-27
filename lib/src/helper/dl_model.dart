import 'package:flutter/foundation.dart';

class DLModel {
  String name;
  String summary;
  String description;
  String inputSize;
  double accuracy;
  bool isSaved;

  DLModel({required this.name, required this.summary, required this.description, required this.inputSize, required this.accuracy, this.isSaved = false});

  Map<String, dynamic> toJson() => {
    'name': name,
    'summary': summary,
    'description': description,
    'inputSize': inputSize,
    'accuracy': accuracy,
    'isSaved': isSaved ? 1 : 0,
  };

  static DLModel fromJson(Map<String, dynamic> json) => DLModel(
    name: json['name'],
    summary: json['summary'],
    description: json['description'],
    inputSize: json['inputSize'],
    accuracy: json['accuracy'].toDouble(),
    isSaved: json['isSaved'] == 1 ? true : false,
  );
}

