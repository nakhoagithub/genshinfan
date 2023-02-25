import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class ItemSetting extends StatelessWidget {
  final Widget? icon;
  final String title;
  final Widget? child;
  final String? description;
  final VoidCallback? onTap;
  const ItemSetting({
    super.key,
    this.icon,
    required this.title,
    this.child,
    this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w,
                height: 45,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    icon == null
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: icon,
                          ),
                    Expanded(
                      child: Text(
                        title,
                        style: ThemeApp.textStyle(
                          isDark: Get.isDarkMode,
                        ),
                      ),
                    ),
                    child ?? const Icon(Icons.keyboard_arrow_right_rounded),
                  ],
                ),
              ),
              description == null
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: Text(
                        "$description",
                        style: ThemeApp.textStyle(
                          isDark: Get.isDarkMode,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
