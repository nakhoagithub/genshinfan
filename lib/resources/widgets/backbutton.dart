import 'package:flutter/material.dart';

class BackButtonApp extends StatelessWidget {
  const BackButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.maybePop(context);
      },
      icon: const Icon(Icons.keyboard_arrow_left_rounded),
    );
  }
}
