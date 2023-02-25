import 'package:flutter/material.dart';

class DividerApp extends StatelessWidget {
  const DividerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 5),
      child: const Divider(
        color: Colors.grey,
        height: 1,
      ),
    );
  }
}