import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/layout.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/orther/controllers/orther_controller.dart';
import 'package:get/get.dart';

class OrtherPage extends StatefulWidget {
  const OrtherPage({super.key});

  @override
  State<OrtherPage> createState() => _OrtherPageState();
}

class _OrtherPageState extends State<OrtherPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.theme;
    return const _List();
  }

  @override
  bool get wantKeepAlive => true;
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    OrtherController ortherController = Get.put(OrtherController());
    List<ItemMenuLayout> menus = ortherController.menus;
    return Obx(() {
      return GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
        childAspectRatio: Get.find<LayoutController>().childAspectRatio.value,
        children: List.generate(
          menus.length,
          (index) {
            return _ItemMenu(
              item: menus[index],
              onTap: () {
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

class _ItemMenu extends StatelessWidget {
  final ItemMenuLayout item;
  final VoidCallback onTap;
  const _ItemMenu({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
                item.icon,
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
