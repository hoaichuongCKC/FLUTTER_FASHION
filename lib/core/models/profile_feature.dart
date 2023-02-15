import 'package:flutter/material.dart';

/// ProfileFeatureModel is a class that has 3 properties: label, imageUrl, and path
class ProfileFeatureModel {
  final String label;

  final String imageUrl;

  final String path;

  final Color color;

  ProfileFeatureModel({
    required this.label,
    required this.imageUrl,
    required this.path,
    required this.color,
  });
}
