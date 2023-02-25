import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconApp extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;
  final bool? notification;
  const IconApp({
    super.key,
    required this.onTap,
    required this.icon,
    this.notification,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 40,
        width: 40,
        child: Stack(
          children: [
            icon,
            notification != null && notification == true
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
