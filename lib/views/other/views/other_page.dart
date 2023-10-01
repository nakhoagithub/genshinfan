import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/layout.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/other/controllers/orther_controller.dart';
import 'package:get/get.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.theme;
    return Container(
      margin: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              child: Text(
                "other".tr,
                style: ThemeApp.textStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const _List(),
            Container(
              margin: const EdgeInsets.all(4),
              child: Text(
                "tool".tr,
                style: ThemeApp.textStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const _ListTool(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    OtherController otherController = Get.put(OtherController());
    List<ItemMenuLayout> menus = otherController.menus;
    return Obx(() {
      return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
        childAspectRatio: Get.find<LayoutController>().childAspectRatio.value,
        children: List.generate(
          menus.length,
          (index) {
            return _ItemMenu(
              item: menus[index],
              onTap: menus[index].onTap ??
                  () {
                    if (menus[index].keyPage != "") {
                      Get.toNamed(menus[index].keyPage);
                    }
                  },
            );
          },
        ),
      );
    });
  }
}

class _ListTool extends StatelessWidget {
  const _ListTool();

  @override
  Widget build(BuildContext context) {
    OtherController otherController = Get.put(OtherController());
    List<ItemMenuLayout> menusTool = otherController.menusTool;
    return Obx(() {
      return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
        childAspectRatio: Get.find<LayoutController>().childAspectRatio.value,
        children: List.generate(
          menusTool.length,
          (index) {
            return _ItemMenu(
              item: menusTool[index],
              onTap: menusTool[index].onTap ??
                  () {
                    if (menusTool[index].keyPage != "") {
                      Get.toNamed(menusTool[index].keyPage);
                    }
                  },
            );
          },
        ),
      );
    });
  }
}

class _ItemMenu extends StatelessWidget {
  final ItemMenuLayout item;
  final VoidCallback onTap;
  const _ItemMenu({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    return Center(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Get.theme.colorScheme.onInverseSurface,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: sizeItem,
            height: sizeItem * 1.215,
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                item.widget ??
                    Image.asset(
                      item.icon ?? "",
                      color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
                      height: item.sizeIcon,
                      width: item.sizeIcon,
                    ),
                Expanded(
                  child: Center(
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeApp.textStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
