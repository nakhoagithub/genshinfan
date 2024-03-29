import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';

class PageEmpty extends StatelessWidget {
  final String title;
  const PageEmpty({super.key, required this.title});

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
