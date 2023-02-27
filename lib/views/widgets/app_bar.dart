import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class AppBarCenter extends StatelessWidget {
  final double width;
  final String title;
  final double? elevation;
  final VoidCallback? onTap;
  final VoidCallback? onTapAction;
  const AppBarCenter({
    Key? key,
    required this.width,
    required this.title,
    this.elevation,
    this.onTap,
    this.onTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Card(
      elevation: elevation ?? 4,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.zero, bottomLeft: Radius.zero)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          height: 55,
          width: width,
          child: Row(
            children: [
              Text(
                title,
                style: ThemeApp.textStyle(
                  isDark: Get.isDarkMode,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onTapAction,
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.more_horiz_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
