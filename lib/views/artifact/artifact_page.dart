import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/artifact/widgets/item_artifact.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class ArtifactPage extends StatelessWidget {
  const ArtifactPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "artifact".tr,
            width: double.infinity,
          ),
          const Expanded(
            child: _List(),
          )
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    ArtifactController artifactController = Get.find<ArtifactController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem3;
    return Obx(() {
      List<Artifact> artifacts = artifactController.artifacts;
      return SizedBox(
          width: Config.widthCenter,
          child: artifacts.isEmpty
              ? ListEmpty(title: "empty_artifact".tr)
              : GridView.count(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 3,
                  childAspectRatio: sizeItem / (sizeItem * 1.215),
                  children: List.generate(
                    artifacts.length,
                    (index) => FadeInUp(
                      child: Center(
                        child: SizedBox(
                          width: sizeItem,
                          height: sizeItem * 1.215,
                          child: ItemArtifact(
                            artifact: artifacts[index],
                            onTap: () {
                              artifactController
                                  .selectArtifact(artifacts[index]);
                              homeController.pageCenter();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
    });
  }
}


// class _List extends StatelessWidget {
//   const _List();

//   @override
//   Widget build(BuildContext context) {
//     context.theme;
//     ArtifactController artifactController = Get.find<ArtifactController>();
//     return ListView.builder(
//         padding: EdgeInsets.zero,
//         physics: const BouncingScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: artifactController.artifacts.length,
//         itemBuilder: (context, index) {
//           return LayoutBuilder(
//             builder: (context, constraints) {
//               double w = constraints.minWidth;
//               double h = w * 0.45;
//               String rarity = artifactController.artifacts[index].rarity[
//                   artifactController.artifacts[index].rarity.length - 1];
//               return FadeInUp(
//                 child: _ItemArtifact(
//                   width: w,
//                   height: h,
//                   artifact: artifactController.artifacts[index],
//                   rarity: rarity,
//                 ),
//               );
//             },
//           );
//         });
//   }
// }

// class _ItemArtifact extends StatelessWidget {
//   final Artifact artifact;
//   final double width;
//   final double height;
//   final String rarity;
//   const _ItemArtifact({
//     required this.artifact,
//     required this.width,
//     required this.height,
//     required this.rarity,
//   });

//   @override
//   Widget build(BuildContext context) {
//     context.theme;
//     return InkWell(
//       onTap: () {
//         Get.find<ArtifactController>().selectArtifact(artifact);
//         Get.find<HomeController>().pageCenter();
//       },
//       borderRadius: BorderRadius.circular(5),
//       child: Card(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         color: ThemeApp.colorBackgroundItemInPage,
//         child: SizedBox(
//           height: height,
//           width: width,
//           child: Stack(
//             children: [
//               // icon artifact
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     top: height * 0.1,
//                     right: width * 0.05,
//                   ),
//                   child: Image.asset(
//                     "assets/images/ic_artifact2.png",
//                     height: height * 0.5,
//                     color: ThemeApp.colorText(isDark: false).withOpacity(0.5),
//                   ),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // title
//                   Center(
//                     child: Container(
//                       margin: const EdgeInsets.only(top: 10),
//                       child: Text(
//                         artifact.name,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: ThemeApp.colorText(isDark: false),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         child: LayoutBuilder(
//                           builder: (p0, p1) {
//                             double h = p1.maxHeight;
//                             return Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 artifact.flower == null
//                                     ? const SizedBox()
//                                     : _ImageArtifact(
//                                         size: h,
//                                         rarity: rarity,
//                                         linkImage: artifact.images?.flower,
//                                       ),
//                                 artifact.plume == null
//                                     ? const SizedBox()
//                                     : _ImageArtifact(
//                                         size: h,
//                                         rarity: rarity,
//                                         linkImage: artifact.images?.plume,
//                                       ),
//                                 artifact.sands == null
//                                     ? const SizedBox()
//                                     : _ImageArtifact(
//                                         size: h,
//                                         rarity: rarity,
//                                         linkImage: artifact.images?.sands,
//                                       ),
//                                 artifact.goblet == null
//                                     ? const SizedBox()
//                                     : _ImageArtifact(
//                                         size: h,
//                                         rarity: rarity,
//                                         linkImage: artifact.images?.goblet,
//                                       ),
//                                 _ImageArtifact(
//                                   size: h,
//                                   rarity: rarity,
//                                   linkImage: artifact.images?.circlet,
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: _ArtifactInfo(
//                       set1: artifact.set1,
//                       set2: artifact.set2,
//                       set4: artifact.set4,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ImageArtifact extends StatelessWidget {
//   final double size;
//   final String rarity;
//   final String? linkImage;
//   const _ImageArtifact({
//     required this.size,
//     required this.rarity,
//     required this.linkImage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     context.theme;
//     return Container(
//       width: size * 0.9,
//       height: size * 0.9,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(size * 0.08),
//           topRight: Radius.circular(size * 0.08),
//           bottomLeft: Radius.circular(size * 0.08),
//           bottomRight: Radius.circular(size * 0.2),
//         ),
//         gradient: GradientApp.getBackgroundRarity(rarity),
//       ),
//       child: CachedNetworkImage(
//         imageUrl: linkImage ?? "",
//         progressIndicatorBuilder: (context, url, progress) {
//           return const Center(
//             child: SizedBox(
//               height: 10,
//               width: 10,
//               child: CircularProgressIndicator(
//                 strokeWidth: 1,
//               ),
//             ),
//           );
//         },
//         errorWidget: (context, url, error) {
//           return Image.asset("assets/images/icon_genshin_error.png");
//         },
//       ),
//     );
//   }
// }

// class _ArtifactInfo extends StatelessWidget {
//   final String? set1;
//   final String? set2;
//   final String? set4;
//   const _ArtifactInfo({
//     required this.set1,
//     required this.set2,
//     required this.set4,
//   });

//   @override
//   Widget build(BuildContext context) {
//     context.theme;
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double h = constraints.maxHeight;
//         return Container(
//           padding: EdgeInsets.only(
//             left: h * 0.2,
//             right: h * 0.2,
//             bottom: h * 0.1,
//           ),
//           child: Column(
//             children: [
//               set1 == null
//                   ? const SizedBox()
//                   : Expanded(
//                       child: _ArtifactSet(
//                         h: h,
//                         set: set1 ?? "",
//                         setNumber: "1",
//                       ),
//                     ),
//               set2 == null
//                   ? const SizedBox()
//                   : Expanded(
//                       child: _ArtifactSet(
//                         h: h,
//                         set: set2 ?? "",
//                         setNumber: "2",
//                       ),
//                     ),
//               set4 == null
//                   ? const SizedBox()
//                   : Expanded(
//                       child: _ArtifactSet(
//                         h: h,
//                         set: set4 ?? "",
//                         setNumber: "4",
//                       ),
//                     ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class _ArtifactSet extends StatelessWidget {
//   final double h;
//   final String set;
//   final String setNumber;
//   const _ArtifactSet({
//     required this.h,
//     required this.set,
//     required this.setNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     context.theme;
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: h * 0.35,
//           width: h * 0.35,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: ThemeApp.colorText(isDark: false).withOpacity(0.5),
//           ),
//           child: Text(
//             setNumber,
//             style: TextStyle(
//               fontSize: h * 0.25,
//               fontWeight: FontWeight.bold,
//               color: ThemeApp.colorText(isDark: true),
//             ),
//           ),
//         ),
//         Flexible(
//           child: Container(
//             margin: EdgeInsets.only(
//               left: h * 0.1,
//             ),
//             child: Text(
//               set,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: h * 0.25,
//                 color: ThemeApp.colorText(isDark: false),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
