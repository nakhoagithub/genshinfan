import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaitAMinute extends StatelessWidget {
  final double? sizeProgressIndicator;
  final double? strokeWidth;
  const WaitAMinute({
    super.key,
    this.sizeProgressIndicator,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: SizedBox(
            height: sizeProgressIndicator ?? 30,
            width: sizeProgressIndicator ?? 30,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth ?? 2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "wait_a_minute".tr,
          ),
        )
      ],
    );
  }
}
