import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';

class ListEmpty extends StatelessWidget {
  final String title;
  const ListEmpty({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: ThemeApp.textStyle(),
      ),
    );
  }
}
