import 'package:flutter/material.dart';

class ImageFailure extends StatelessWidget {
  final double size;
  const ImageFailure({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/ic_image_failure.png",
        height: size,
        width: size,
      ),
    );
  }
}
