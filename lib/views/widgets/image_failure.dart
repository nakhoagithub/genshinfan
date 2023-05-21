import 'package:flutter/material.dart';

class ImageFailure extends StatelessWidget {
  const ImageFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/ic_image_failure.png",
        height: 40,
        width: 40,
      ),
    );
  }
}
