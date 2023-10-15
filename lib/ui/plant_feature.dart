// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class PlantFeature extends StatelessWidget {
  const PlantFeature({
    required this.assetImage,
    required this.title,
    required this.subTitle,
    super.key,
  });

  final String assetImage;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(assetImage, height: 45),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subTitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
