import 'package:flutter/material.dart';

class GradientApp {
  static Gradient getBackgroundRarity(String? rarity) {
    LinearGradient gradient = GradientApp.bg1sGradient();
    switch (rarity) {
      case "1":
        gradient = GradientApp.bg1sGradient();
        break;
      case "2":
        gradient = GradientApp.bg2sGradient();
        break;
      case "3":
        gradient = GradientApp.bg3sGradient();
        break;
      case "4":
        gradient = GradientApp.bg4sGradient();
        break;
      case "5":
        gradient = GradientApp.bg5sGradient();
        break;
    }
    return gradient;
  }

  static bg5sGradient() {
    return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff955d2c),
          Color(0xffb27330),
        ]);
  }

  static bg4sGradient() {
    return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff61598b),
          Color(0xff8f6fae),
        ]);
  }

  static bg3sGradient() {
    return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff567698),
          Color(0xff5392b8),
        ]);
  }

  static bg2sGradient() {
    return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff4b6d67),
          Color(0xff519072),
        ]);
  }

  static bg1sGradient() {
    return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff6b6e75),
          Color(0xff888789),
        ]);
  }
}
