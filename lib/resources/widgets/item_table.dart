import 'package:flutter/material.dart';

class ItemTable extends StatelessWidget {
  final String title;
  const ItemTable({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Text(title, textAlign: TextAlign.center),
    );
  }
}