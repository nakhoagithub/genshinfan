import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';

class ItemWeapon extends StatelessWidget {
  final Weapon weapon;
  final VoidCallback onTap;
  const ItemWeapon({
    super.key,
    required this.weapon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double sizeItem = Config.sizeItem3;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(sizeItem * 0.05),
      child: Container(
        margin: const EdgeInsets.all(2),
        width: sizeItem,
        height: sizeItem * 1.215,
        child: Stack(
          children: [
            // background
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizeItem * 0.05),
              ),
              child: Image.asset(
                Tools.getBackground(weapon.rarity),
                fit: BoxFit.cover,
                height: sizeItem * 1.215,
                width: sizeItem,
              ),
            ),

            // image, name
            Column(
              children: [
                Expanded(
                  // image
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(sizeItem * 0.2),
                        topLeft: Radius.circular(sizeItem * 0.05),
                        topRight: Radius.circular(sizeItem * 0.05),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: weapon.images?.icon ??
                          Config.urlImage(weapon.images?.namegacha),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) {
                        return const Center(
                          child: SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported_rounded,
                            color: Colors.black54,
                            size: 16,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // name
                Container(
                  height: sizeItem * 0.205,
                  width: sizeItem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(sizeItem * 0.05),
                      bottomRight: Radius.circular(sizeItem * 0.05),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      weapon.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[850],
                        fontSize: sizeItem * 0.16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // type
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(2),
                height: sizeItem * 0.25,
                width: sizeItem * 0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Tools.getAssetWeaponType(weapon.weapontype) != null
                    ? Image.asset(
                        Tools.getAssetWeaponType(weapon.weapontype) ?? "")
                    : const SizedBox(),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: Image.asset(
                  Tools.getRarityStar(weapon.rarity),
                  height: sizeItem * 1.215 * 0.18,
                  width: sizeItem * 0.85,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
