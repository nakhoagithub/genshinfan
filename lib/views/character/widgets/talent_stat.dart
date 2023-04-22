import 'package:flutter/material.dart';
import 'package:genshinfan/objects/talent.dart';
import 'package:get/get.dart';

import '../../../resources/utils/theme.dart';

class TalentStats extends StatelessWidget {
  final Combat combat;
  const TalentStats({
    super.key,
    required this.combat,
  });

  @override
  Widget build(BuildContext context) {
    List<Attribute?> attrs = combat.attrs ?? [];

    double heightHeader = 80;
    double heightItem = 50;
    double widthItem = 150;
    return Container(
      color: Get.theme.cardColor,
      height: Get.height * 0.9,
      width: Get.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      "talent_stats".tr,
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              16,
                              (index) {
                                if (index == 0) {
                                  return _Cell(
                                    height: heightHeader,
                                    width: 60,
                                    border: 3,
                                    child: Text("level".tr),
                                  );
                                } else {
                                  return _Cell(
                                    height: heightItem,
                                    width: 60,
                                    border: 1,
                                    child: Text("$index"),
                                  );
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: List.generate(
                                16,
                                (index) {
                                  if (index == 0) {
                                    if (attrs[index] != null) {
                                      return Row(
                                        children: [
                                          ...attrs.asMap().entries.map((e) {
                                            return _Cell(
                                              height: heightHeader,
                                              width: widthItem,
                                              border: e.key == 0 ? 3 : 2,
                                              child: Text(
                                                "${e.value?.name}",
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                          }),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  } else {
                                    return Row(
                                      children: [
                                        ...attrs.asMap().entries.map((e) {
                                          return _Cell(
                                            height: heightItem,
                                            width: widthItem,
                                            border: e.key == 0 ? 1 : 0,
                                            child: Text(
                                              "${e.value?.params[index - 1]}",
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }),
                                      ],
                                    );
                                  }
                                },
                              ),
                              // children: [

                              //   ...attrs.asMap().entries.map((e) {
                              //     Attribute? attribute = e.value;
                              //     if (attribute == null) {
                              //       return const SizedBox();
                              //     } else {
                              //       return Row(
                              //         children: [
                              //           ...e.value!.params.asMap().entries.map((e) {
                              //             return _Cell(
                              //               height: height,
                              //               width: 100,
                              //               child: Text(
                              //                 e.value,
                              //                 textAlign: TextAlign.center,
                              //               ),
                              //             );
                              //           }),
                              //         ],
                              //       );
                              //     }
                              //   }),
                              // ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final double height;
  final double? width;
  final Widget child;

  // 1 thì border left
  // 2 thì border top
  // 3 thì all
  final int border;
  const _Cell({
    required this.height,
    this.width,
    required this.child,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    BorderSide borderSide = BorderSide(
      color: Get.theme.colorScheme.onSurface,
    );
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          left: border == 1 || border == 3 ? borderSide : BorderSide.none,
          top: border == 2 || border == 3 ? borderSide : BorderSide.none,
          bottom: borderSide,
          right: borderSide,
        ),
      ),
      child: Center(child: child),
    );
  }
}
