import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconApp extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
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
    return Stack(
      children: [
        notification == true
            ? Positioned(
                top: 12,
                right: 12,
                child: FadeIn(
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        IconButton(
          onPressed: onTap,
          icon: icon,
        ),
      ],
    );
  }
}
