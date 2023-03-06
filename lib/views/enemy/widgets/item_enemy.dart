import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/objects/enemy.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';

class ItemEnemy extends StatelessWidget {
  final Enemy enemy;
  final VoidCallback onTap;
  const ItemEnemy({
    super.key,
    required this.enemy,
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
                Tools.getBackground("1"),
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
                      imageUrl: Config.urlImage(enemy.images?.nameicon),
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
                      enemy.name,
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
          ],
        ),
      ),
    );
  }
}
