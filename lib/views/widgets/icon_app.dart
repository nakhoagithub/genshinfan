import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconApp extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final bool? notification;
  const IconApp({
    super.key,
    required this.onTap,
    required this.child,
    this.notification,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    return IconButton(
        onPressed: onTap,
        icon: SizedBox(
          height: 40,
          width: 40,
          child: Stack(
            children: [
              Center(child: child),
              notification != null && notification == true
                  ? Align(
                      alignment: Alignment.topRight,
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
            ],
          ),
        ));
  }
}
