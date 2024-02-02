import 'package:flutter/material.dart';

class CircularProgressApp extends StatelessWidget {
  const CircularProgressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 15,
        width: 15,
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
    );
  }
}
