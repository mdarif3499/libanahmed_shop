import 'package:flutter/material.dart';

double getResponsiveAspectRatio(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  // Responsive aspect ratio based on screen size
  if (screenWidth < 360) {
    // Very small devices
    return 0.6;
  } else if (screenWidth < 400) {
    // Small devices
    return 0.75;
  } else if (screenWidth < 600) {
    // Medium devices
    return 0.85;
  } else {
    // Large devices (tablets, etc.)
    return 0.9;
  }
}
