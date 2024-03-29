import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:get/get.dart';

class AppBarCenter extends StatelessWidget {
  final double width;
  final String title;
  final List<Widget>? actions;
  final double? elevation;
  final VoidCallback? onTap;
  const AppBarCenter({
    Key? key,
    required this.width,
    required this.title,
    this.actions,
    this.elevation,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Card(
      elevation: elevation ?? 4,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          height: 55,
          width: width,
          child: Row(
            children: [
              Text(
                title,
                style: ThemeApp.textStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              actions == null
                  ? const SizedBox()
                  : Wrap(
                      children: [
                        ...actions!.map((e) => e),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
