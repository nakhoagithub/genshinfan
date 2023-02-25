// /// Create by Anh Khoa
// import 'dart:async';

// import 'package:flutter/material.dart';

// enum ScreenPosition { left, right, center }

// class SlideLayout extends StatefulWidget {
//   final List<ItemMenuLeftBar> childrenLeftBar;
//   final List<Widget>? actionBottomLeftBar;
//   final Widget right;
//   final Widget home;
//   final String linkImageMenuHome;
//   final Color? backgroundColor;
//   final Color? iconBackgroundColor;
//   final Color? iconColor;
//   final Color? indicatorColor;

//   /// `value = 1` open screen right
//   /// `value = 2` open screen center
//   /// `value = 3` open screen left
//   final StreamController<ScreenPosition>? stream;
//   const SlideLayout({
//     super.key,
//     required this.childrenLeftBar,
//     this.actionBottomLeftBar,
//     required this.right,
//     required this.home,
//     required this.linkImageMenuHome,
//     this.backgroundColor,
//     this.iconBackgroundColor,
//     this.iconColor,
//     this.indicatorColor,
//     this.stream,
//   });

//   @override
//   State<SlideLayout> createState() => _SlideLayoutState();
// }

// class _SlideLayoutState extends State<SlideLayout>
//     with TickerProviderStateMixin {
//   StreamController<ScreenPosition> stream = StreamController<ScreenPosition>();

//   @override
//   void dispose() {
//     stream.close();
//     super.dispose();
//   }

//   bool buildFirst = false;
//   Orientation orientationFirst = Orientation.portrait;
//   double positionLeftOfScreen = 0;
//   Offset offsetDown = Offset.zero;
//   double dragWidth = 0;
//   Duration duration = const Duration(milliseconds: 100);

//   /// status  = 1 left
//   ///         = 2 center
//   ///         = 3 right
//   int statusScreen = 3;

//   /// status  = false   not padding
//   ///         = true    padding
//   bool statusScreenPadding = true;

//   /// ẩn bar
//   /// hide = true -> ẩn Left and Center
//   bool hideLeftAndCenter = false;

//   // left bar
//   int currentIndex = 0;
//   double marginRight = 0;

//   onTap(int index, double width) {
//     setState(() {
//       currentIndex = index;
//       if (currentIndex == 0) {
//         marginRight = 0;
//       } else {
//         marginRight = 40;
//       }
//       screenRight(width);
//     });
//   }

//   void screenLeft(double width) {
//     setState(() {
//       positionLeftOfScreen = (0 - width) + 40;
//       statusScreen = 1;
//       statusScreenPadding = true;
//     });
//   }

//   void screenCenter() {
//     setState(() {
//       positionLeftOfScreen = 0;
//       statusScreen = 2;
//       statusScreenPadding = false;
//     });
//   }

//   void screenRight(double width) {
//     setState(() {
//       positionLeftOfScreen = width - marginRight;
//       statusScreen = 3;
//       statusScreenPadding = true;
//     });
//   }

//   // update UI khi animation kết thúc
//   void _onEndAnimation() {
//     setState(() {});
//   }

//   void onHorizontalDragDown(DragDownDetails details) {
//     if (currentIndex == 0) {
//       return;
//     }
//     setState(() {
//       offsetDown = details.globalPosition;
//     });
//   }

//   void onHorizontalDragUpdate(DragUpdateDetails details, double width) {
//     if (currentIndex == 0) {
//       return;
//     }
//     double drag = offsetDown.dx - details.localPosition.dx;
//     setState(() {
//       if (positionLeftOfScreen == 0) {
//         /// screen center
//         dragWidth = drag;
//       } else if (positionLeftOfScreen < 0) {
//         /// left
//         if (positionLeftOfScreen - drag > positionLeftOfScreen) {
//           dragWidth = drag;
//           statusScreenPadding = false;
//         }
//       } else {
//         if (positionLeftOfScreen - drag < positionLeftOfScreen) {
//           dragWidth = drag;
//           statusScreenPadding = false;
//         }
//       }

//       /// ẩn hiện layout

//       if ((statusScreen == 2 || statusScreen == 3) &&
//           positionLeftOfScreen - drag > 0) {
//         hideLeftAndCenter = false;
//       }
//       if ((statusScreen == 2 || statusScreen == 1) &&
//           positionLeftOfScreen - drag < 0) {
//         hideLeftAndCenter = true;
//       }
//     });
//   }

//   void onHorizontalDragEnd(DragEndDetails details, double width) {
//     if (currentIndex == 0) {
//       return;
//     }
//     Offset velocityOffset = details.velocity.pixelsPerSecond;
//     double positionL = positionLeftOfScreen - dragWidth;
//     double positionR = positionL + width;

//     if (velocityOffset.dx < -1200 || velocityOffset.dx > 1200) {
//       if (velocityOffset.dx > 1200) {
//         if (statusScreen == 1) {
//           screenCenter();
//         } else if (statusScreen == 2) {
//           screenRight(width);
//         } else {
//           screenRight(width);
//         }
//       } else {
//         if (statusScreen == 3) {
//           screenCenter();
//         } else if (statusScreen == 2) {
//           // đang ở screen mở right
//           if (widget.childrenLeftBar[currentIndex].right != null) {
//             screenLeft(width);
//           }
//           // screenLeft(width);
//         } else {
//           screenLeft(width);
//         }
//       }
//     } else {
//       if (positionL >= width * 0.5) {
//         screenRight(width);
//       } else if (positionR <= width * 0.5) {
//         if (widget.childrenLeftBar[currentIndex].right != null) {
//           screenLeft(width);
//         } else {
//           screenCenter();
//         }
//       } else {
//         screenCenter();
//       }
//     }

//     offsetDown = Offset.zero;
//     dragWidth = 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     // double heightStatus = MediaQuery.of(context).viewPadding.top;
//     Orientation orientation = MediaQuery.of(context).orientation;

//     /// lấy chiều rộng lần đầu tiên
//     if (!buildFirst) {
//       orientationFirst = orientation;
//       buildFirst = true;
//       statusScreenPadding = true;
//       positionLeftOfScreen = width - marginRight;
//       if (widget.stream != null) {
//         stream = widget.stream ?? StreamController<ScreenPosition>();
//       }
//       stream.stream.listen(
//         (value) {
//           if (marginRight != 0) {
//             switch (value) {
//               case ScreenPosition.left:
//                 screenLeft(width);
//                 break;
//               case ScreenPosition.right:
//                 screenRight(width);
//                 break;
//               case ScreenPosition.center:
//                 screenCenter();
//                 break;
//             }
//           }
//         },
//       );
//     }

//     /// build lại khi đổi hướng màn hình
//     if (orientation != orientationFirst) {
//       orientationFirst = orientation;
//       buildFirst = true;
//       statusScreenPadding = true;
//       positionLeftOfScreen = width - marginRight;
//     }

//     return GestureDetector(
//       onHorizontalDragDown: (details) => onHorizontalDragDown(details),
//       onHorizontalDragUpdate: (details) =>
//           onHorizontalDragUpdate(details, width),
//       onHorizontalDragEnd: (details) => onHorizontalDragEnd(details, width),
//       child: Stack(
//         children: [
//           Container(width: width * 2.5),
//           // left and center
//           IndexedStack(
//             index: hideLeftAndCenter ? 1 : 0,
//             children: [
//               Row(
//                 children: [
//                   // left
//                   SafeArea(
//                     child: SizedBox(
//                       width: 60,
//                       height: height,
//                       child: Column(
//                         children: [
//                           // menu home
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 10),
//                             child: _IconApp(
//                               iconColor: widget.iconColor,
//                               iconBackgroundColor: widget.iconBackgroundColor,
//                               indicatorColor: widget.indicatorColor,
//                               index: 0,
//                               currentIndex: currentIndex,
//                               onTap: () => onTap(0, width),
//                               child: Image.asset(
//                                 widget.childrenLeftBar[0].linkImage,
//                               ),
//                             ),
//                           ),
//                           const _DividerApp(),
//                           // list menu
//                           Expanded(
//                             child: ListView.builder(
//                               physics: const BouncingScrollPhysics(),
//                               itemCount: widget.childrenLeftBar.length - 1,
//                               itemBuilder: (context, index) {
//                                 int i = index + 1;
//                                 return _IconApp(
//                                   iconColor: widget.iconColor,
//                                   iconBackgroundColor:
//                                       widget.iconBackgroundColor,
//                                   indicatorColor: widget.indicatorColor,
//                                   index: i,
//                                   currentIndex: currentIndex,
//                                   onTap: () => onTap(i, width),
//                                   child: Image.asset(
//                                     widget.childrenLeftBar[i].linkImage,
//                                     color: widget.iconColor,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           widget.actionBottomLeftBar == null
//                               ? const SizedBox()
//                               : Container(
//                                   margin: const EdgeInsets.only(
//                                       bottom: 10, top: 10),
//                                   child: Column(
//                                     children: widget.actionBottomLeftBar!.map(
//                                       (e) {
//                                         return e;
//                                       },
//                                     ).toList(),
//                                   ),
//                                 )
//                         ],
//                       ),
//                     ),
//                   ),
//                   // center
//                   Expanded(
//                     child: IndexedStack(
//                       index: currentIndex,
//                       children: [
//                         ...widget.childrenLeftBar.map((e) {
//                           return SafeArea(
//                             child: AnimatedContainer(
//                               duration: duration,
//                               width:
//                                   currentIndex == 0 ? width - 60 : width - 100,
//                               height: height,
//                               child: Stack(
//                                 children: [
//                                   SizedBox(
//                                     width: width - 60,
//                                   ),
//                                   Card(
//                                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                                     margin: EdgeInsets.zero,
//                                     child: e.widget,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(),
//             ],
//           ),

//           // right
//           // Positioned(
//           //   left: 40,
//           //   width: width - 40,
//           //   height: height,
//           //   child: IndexedStack(
//           //     index: hideLeftAndCenter ? 0 : 1,
//           //     children: [
//           //       SafeArea(
//           //         child: Card(
//           //           margin: EdgeInsets.zero,
//           //           clipBehavior: Clip.antiAliasWithSaveLayer,
//           //           child: widget.right,
//           //         ),
//           //       ),
//           //       const SizedBox(),
//           //     ],
//           //   ),
//           // ),

//           // screen
//           AnimatedPositioned(
//             onEnd: _onEndAnimation,
//             duration: duration,
//             left: currentIndex == 0 ? width : positionLeftOfScreen - dragWidth,
//             width: width,
//             height: height,
//             child: SizedBox(
//               width: width,
//               height: height,
//               child: GestureDetector(
//                 onTap: () {
//                   screenCenter();
//                 },
//                 child: SafeArea(
//                   top: statusScreenPadding ? true : false,
//                   child: Card(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: statusScreen == 2
//                           ? BorderRadius.zero
//                           : BorderRadius.circular(4),
//                     ),
//                     margin: statusScreenPadding
//                         ? const EdgeInsets.only(left: 5, right: 5)
//                         : EdgeInsets.zero,
//                     child: widget.childrenLeftBar[currentIndex].screen,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ItemMenuLeftBar {
//   final String linkImage;
//   final Widget widget;
//   final Widget screen;
//   final Widget? right;
//   ItemMenuLeftBar({
//     required this.linkImage,
//     required this.widget,
//     required this.screen,
//     this.right,
//   });
// }

// class _IconApp extends StatelessWidget {
//   final int index;
//   final int currentIndex;
//   final VoidCallback onTap;
//   final Widget child;
//   final Color? iconColor;
//   final Color? iconBackgroundColor;
//   final Color? indicatorColor;
//   const _IconApp({
//     required this.index,
//     required this.currentIndex,
//     required this.onTap,
//     required this.child,
//     this.iconColor,
//     this.iconBackgroundColor,
//     this.indicatorColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Duration duration = const Duration(milliseconds: 100);
//     double width = 60;
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Row(
//           children: [
//             AnimatedContainer(
//               duration: duration,
//               decoration: BoxDecoration(
//                 color: indicatorColor ?? iconColor,
//                 borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(2),
//                   bottomRight: Radius.circular(2),
//                 ),
//               ),
//               height: index == currentIndex ? width * 0.5 : 0,
//               width: 4,
//             ),
//             AnimatedContainer(
//               duration: duration,
//               margin: const EdgeInsets.only(left: 8),
//               padding: index == 0 ? null : const EdgeInsets.all(5),
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               decoration: BoxDecoration(
//                 color: iconBackgroundColor,
//                 borderRadius: BorderRadius.circular(
//                     index == currentIndex ? width / 5 : width / 2),
//               ),
//               height: 42,
//               width: 42,
//               child: child,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _DividerApp extends StatelessWidget {
//   const _DividerApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 10, right: 5),
//       child: const Divider(
//         color: Colors.grey,
//         height: 1,
//       ),
//     );
//   }
// }
