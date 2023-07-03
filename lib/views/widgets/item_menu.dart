import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:get/get.dart';

class ItemMenu extends StatelessWidget {
  final Widget? icon;
  final String title;
  final Widget? child;
  final String? description;
  final bool? notification;
  final VoidCallback? onTap;
  const ItemMenu({
    super.key,
    this.icon,
    required this.title,
    this.child,
    this.description,
    this.notification,
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
                      child: Row(
                        children: [
                          Text(
                            title,
                            style: ThemeApp.textStyle(),
                          ),
                          const SizedBox(width: 10),
                          notification == null || notification == false
                              ? const SizedBox()
                              : Container(
                                  height: 8,
                                  width: 8,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                        ],
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
