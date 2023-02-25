import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/domain_controller.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/info_text_color_widget.dart';
import 'package:genshinfan/views/widgets/info_text_widget.dart';
import 'package:genshinfan/views/widgets/info_daysofweek_widget.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:get/get.dart';

class InformationDomain extends StatelessWidget {
  const InformationDomain({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    DomainController domainController = Get.find<DomainController>();
    return Obx(() {
      Domain domain = domainController.domain.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    domain.name,
                    textAlign: TextAlign.center,
                    style: ThemeApp.textStyle(
                      isDark: Get.isDarkMode,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _InformationMore(
                domain: domain,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _InformationMore extends StatelessWidget {
  final Domain domain;
  const _InformationMore({required this.domain});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // vùng
          InfoTextColorWidget(titleTranslate: "region", data: domain.region),

          // domainentrance
          domain.domainentrance == null
              ? const SizedBox()
              : InfoTextWidget(
                  titleTranslate: "domainentrance",
                  data: domain.domainentrance ?? ""),

          // Ngày mở bí cảnh
          domain.daysofweek == null
              ? const SizedBox()
              : InfoDaysOfWeekWidget(data: domain.daysofweek!),

          // mô tả
          InfoParagraphWidget(
              titleTranslate: "description", data: domain.description),
        ],
      ),
    );
  }
}
