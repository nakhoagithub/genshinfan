import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';

class TitleOfContent extends StatelessWidget {
  final String title;
  const TitleOfContent({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          margin: const EdgeInsets.only(top: 20, bottom: 5),
          child: const Divider(height: 2),
        ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: ThemeApp.textStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              // color: ThemeApp.colorText(
              //
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
