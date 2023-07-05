import 'package:flutter/material.dart';

class BackButtonApp extends StatelessWidget {
  final IconData? icon;
  const BackButtonApp({
    super.key,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.maybePop(context);
      },
      icon: Icon(icon ?? Icons.keyboard_arrow_left_rounded),
    );
  }
}
