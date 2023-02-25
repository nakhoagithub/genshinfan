import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

enum ScreenPosition { left, right, center }

class SlideLayout extends StatefulWidget {
  final List<ItemSlide> items;
  final double restWidth;
  final ValueChanged<ScreenPosition>? onSideChange;
  final Duration duration;
  final StreamController<ScreenPosition>? streamChangeScreen;
  final List<Widget>? actionBottomLeftBar;
  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final Color? indicatorColor;
  const SlideLayout({
    super.key,
    required this.items,
    this.restWidth = 40,
    this.onSideChange,
    this.duration = const Duration(milliseconds: 100),
    this.streamChangeScreen,
    this.actionBottomLeftBar,
    this.backgroundColor,
    this.iconBackgroundColor,
    this.iconColor,
    this.indicatorColor,
  });

  static SlideLayoutState? of(BuildContext context) {
    return context.findAncestorStateOfType<SlideLayoutState>();
  }

  @override
  State<StatefulWidget> createState() {
    return SlideLayoutState();
  }
}

class SlideLayoutState extends State<SlideLayout>
    with TickerProviderStateMixin {
  AnimationController? controller;
  double translate = 0;
  double screenPaddingTop = 24;
  double marginRight = 0;
  // 1 left
  // 2 center
  // 3 right
  int statusScreen = 3;
  int selected = 0;

  int test = 0;

  double _calculateGoal(double width, int multiplier) {
    return (multiplier * width) + (-multiplier * widget.restWidth);
  }

  void _setPaddingTop(double value) {
    double w = MediaQuery.of(context).size.width;
    setState(() {
      if (value == w - widget.restWidth || -value == w - widget.restWidth) {
        screenPaddingTop = 24;
      } else {
        // nếu đang left mà vuốt trái thì không đổi
        // nếu đang right mà vuốt phải thì không đổi
        if ((statusScreen == 1 && -translate == w - widget.restWidth) ||
            (statusScreen == 3 && translate == w - widget.restWidth)) {
          screenPaddingTop = 24;
        } else {
          screenPaddingTop = 0;
        }
      }
    });
  }

  void _onApplyTranslation() {
    final mediaWidth = MediaQuery.of(context).size.width;

    final animationController =
        AnimationController(vsync: this, duration: widget.duration);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onSideChange != null) {
          widget.onSideChange!(
            translate == 0
                ? ScreenPosition.center
                : (translate > 0 ? ScreenPosition.left : ScreenPosition.right),
          );
        }
        animationController.dispose();
      }
    });

    if (translate.abs() >= mediaWidth / 2) {
      final checkNullRight = widget.items[selected].right != null ? -1 : 0;
      final multiplier = (translate > 0 ? 1 : checkNullRight);
      final goal = _calculateGoal(mediaWidth, multiplier);
      final Tween<double> tween = Tween(begin: translate, end: goal);

      final animation = tween.animate(animationController);

      animation.addListener(() {
        setState(() {
          translate = animation.value;
          statusScreen = multiplier == 1 ? 3 : (multiplier == -1 ? 1 : 2);
          _setPaddingTop(translate);
        });
      });
    } else {
      final animation =
          Tween<double>(begin: translate, end: 0).animate(animationController);

      animation.addListener(() {
        setState(() {
          translate = animation.value;
          statusScreen = 2;
          _setPaddingTop(translate);
        });
      });
    }

    animationController.forward();
  }

  void reveal(ScreenPosition position) {
    // can only reveal when showing center
    // if (translate != 0) {
    //   return;
    // }

    final mediaWidth = MediaQuery.of(context).size.width;
    // final checkNullRight = widget.items[select].right != null ? 1 : 0;
    final multiplier = (position == ScreenPosition.center
        ? 0
        : (position == ScreenPosition.left ? -1 : 1));
    final goal = _calculateGoal(mediaWidth, multiplier);

    final animationController =
        AnimationController(vsync: this, duration: widget.duration);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onApplyTranslation();
      }
    });

    final animation =
        Tween<double>(begin: translate, end: goal).animate(animationController);

    animation.addListener(() {
      setState(() {
        translate = animation.value;
        _setPaddingTop(translate);
      });
    });

    animationController.forward();
  }

  void onTranslate(double delta) {
    // ở màn hình home thì không được vuốt
    if (selected == 0) {
      return;
    }
    double width = MediaQuery.of(context).size.width;
    setState(() {
      final translate = this.translate + delta;
      if (translate < 0 && widget.items[selected].right != null ||
          translate > 0) {
        // không cho lướt khi đang 3
        if (statusScreen == 3 && translate < width - widget.restWidth) {
          this.translate = translate;
        }
        // được lướt khi đang ở giữa
        if (statusScreen == 2) {
          this.translate = translate;
        }
        // không cho lướt khi đang 1
        if (statusScreen == 1 && -translate < width - widget.restWidth) {
          this.translate = translate;
        }
      } else if (translate < 0 && widget.items[selected].right == null) {
        // right null thì không được kéo nữa
        this.translate = translate;
      }
      _setPaddingTop(translate);
    });
  }

  void _quickSwipe(Velocity velocity) {
    if (velocity.pixelsPerSecond.dx < -1200) {
      if (statusScreen == 2 && widget.items[selected].right != null) {
        reveal(ScreenPosition.left);
      }
      if (statusScreen == 3) {
        reveal(ScreenPosition.center);
      }
    }
    if (velocity.pixelsPerSecond.dx > 1200) {
      if (statusScreen == 2) {
        reveal(ScreenPosition.right);
      }
      if (statusScreen == 1) {
        reveal(ScreenPosition.center);
      }
    }
  }

  double _calcWidthLeft(double width) {
    if (widget.items[selected].center != null) {
      return width - widget.restWidth;
    } else {
      return width;
    }
  }

  void _onTap(int index) {
    setState(() {
      selected = index;
      if (selected == 0) {
        marginRight = 0;
      } else {
        marginRight = 40;
      }
    });
  }

  bool _firstBuild = true;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      widget.streamChangeScreen?.stream.listen(
        (value) {
          switch (value) {
            case ScreenPosition.left:
              reveal(ScreenPosition.left);
              break;
            case ScreenPosition.right:
              reveal(ScreenPosition.right);
              break;
            case ScreenPosition.center:
              reveal(ScreenPosition.center);
              break;
          }
        },
      );
    }
  }

  DateTime? currentBackPressTime;

  Future<bool> doubleExitApp() async {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        (currentBackPressTime != null
            ? now.difference(currentBackPressTime!) > const Duration(seconds: 2)
            : false)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "double_click_exit".tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double autoPaddingTop = 24;

    // tạo màng hình ban đầu
    if (_firstBuild) {
      translate = w - widget.restWidth;
      _firstBuild = false;
    }
    return WillPopScope(
      onWillPop: () async {
        if (statusScreen != 3) {
          if (statusScreen == 2) {
            reveal(ScreenPosition.right);
          }
          if (statusScreen == 1) {
            reveal(ScreenPosition.center);
          }
          return false;
        } else {
          return await doubleExitApp();
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: (details) {
          onTranslate(details.delta.dx);
        },
        onHorizontalDragEnd: (details) {
          _onApplyTranslation();
          _quickSwipe(details.velocity);
        },
        child: Stack(
          children: [
            // menu + left
            SizedBox(
              width: _calcWidthLeft(w),
              child: Offstage(
                offstage: translate < 0,
                child: Container(
                  margin: EdgeInsets.only(top: autoPaddingTop, right: 4),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: [
                      // menu
                      SizedBox(
                        width: 60,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: _IconApp(
                                iconColor: widget.iconColor,
                                iconBackgroundColor: widget.iconBackgroundColor,
                                indicatorColor: widget.indicatorColor,
                                index: 0,
                                currentIndex: selected,
                                onTap: () => _onTap(0),
                                child: Image.asset(
                                  widget.items[0].linkImageAsset,
                                ),
                              ),
                            ),
                            const _DividerApp(),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                itemCount: widget.items.length - 1,
                                itemBuilder: (context, index) {
                                  int i = index + 1;
                                  return _IconApp(
                                    iconColor: widget.iconColor,
                                    iconBackgroundColor:
                                        widget.iconBackgroundColor,
                                    indicatorColor: widget.indicatorColor,
                                    index: i,
                                    currentIndex: selected,
                                    onTap: () => _onTap(i),
                                    child: Image.asset(
                                      widget.items[i].linkImageAsset,
                                      color: widget.iconColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                            widget.actionBottomLeftBar == null
                                ? const SizedBox()
                                : Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 12, top: 12),
                                    child: Column(
                                      children: widget.actionBottomLeftBar!.map(
                                        (e) {
                                          return e;
                                        },
                                      ).toList(),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      // left
                      Expanded(
                        child: Stack(
                          children: [
                            ...widget.items.asMap().entries.map(
                              (e) {
                                return Offstage(
                                  offstage: selected == e.key ? false : true,
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: EdgeInsets.zero,
                                    child: e.value.left,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // right
            Positioned(
              left: widget.restWidth,
              width: w - widget.restWidth,
              height: h,
              child: Offstage(
                offstage: translate > 0,
                child: Container(
                  margin:
                      EdgeInsets.only(top: autoPaddingTop, left: 4, right: 2),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ...widget.items.asMap().entries.map((e) {
                        return Offstage(
                          offstage: selected == e.key ? false : true,
                          child: e.value.right,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            // center
            Transform.translate(
              offset: Offset(translate, 0),
              child: SafeArea(
                top: screenPaddingTop != 0 ? true : false,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenPaddingTop != 0 ? 4 : 0),
                      topRight: Radius.circular(screenPaddingTop != 0 ? 4 : 0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ...widget.items.asMap().entries.map((e) {
                        return Offstage(
                          offstage: selected == e.key ? false : true,
                          child: GestureDetector(
                            onTap: () {
                              if (statusScreen != 2) {
                                reveal(ScreenPosition.center);
                              }
                            },
                            child: AbsorbPointer(
                              absorbing: statusScreen == 2 ? false : true,
                              child: e.value.center,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.streamChangeScreen?.close();
    super.dispose();
  }
}

class _IconApp extends StatelessWidget {
  final int index;
  final int currentIndex;
  final VoidCallback onTap;
  final Widget child;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? indicatorColor;
  const _IconApp({
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.child,
    this.iconColor,
    this.iconBackgroundColor,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    Duration duration = const Duration(milliseconds: 200);
    double width = 60;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            AnimatedContainer(
              duration: duration,
              decoration: BoxDecoration(
                color: indicatorColor ?? iconColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
              height: index == currentIndex ? width * 0.5 : 0,
              width: 4,
            ),
            AnimatedContainer(
              duration: duration,
              margin: const EdgeInsets.only(left: 8),
              padding: index == 0 ? null : const EdgeInsets.all(5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(
                    index == currentIndex ? width / 5 : width / 2),
              ),
              height: 42,
              width: 42,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _DividerApp extends StatelessWidget {
  const _DividerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 5),
      child: const Divider(
        color: Colors.grey,
        height: 1,
      ),
    );
  }
}

class ItemSlide {
  final String linkImageAsset;
  final Widget left;
  final Widget? center;
  final Widget? right;
  const ItemSlide({
    required this.linkImageAsset,
    required this.left,
    this.center,
    this.right,
  });
}
