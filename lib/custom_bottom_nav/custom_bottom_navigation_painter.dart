import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samples/custom_bottom_nav/home_screen.dart';

class IconItem {
  final String svg;
  final String title;
  final Function()? onTap;

  IconItem({
    this.onTap,
    required this.svg,
    required this.title,
  });
}

class MainHomeScreen extends StatefulWidget {
  final IconItem? leftIcon;
  final IconItem? topIcon;
  final IconItem? rightIcon;
  final Color? splashColor;
  const MainHomeScreen({
    super.key,
    this.leftIcon,
    this.rightIcon,
    this.topIcon,
    this.splashColor = const Color.fromARGB(143, 131, 240, 207),
  });

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with TickerProviderStateMixin {
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();
  final ValueNotifier<int> pageIndex = ValueNotifier<int>(0);
  bool isOverlayCreated = false;

  late AnimationController rotateAnimationController;

  late final Tween<double> rotationTween;
  late final Tween<double> sizeTween;

  late final Animation<double> rotatedAnimation;
  late final Animation<double> sizeAnimation;

  static const int durationInMilliSeconds = 200;

  void removeOverlay() {
    isOverlayCreated = false;
    overlayEntry?.remove();
    overlayEntry = null;
  }

  createOverLay() {
    assert(overlayEntry == null);
    if (!isOverlayCreated) {
      isOverlayCreated = true;
      overlayEntry = OverlayEntry(
        maintainState: true,
        builder: (BuildContext context) {
          return OverLayWidget(
            leftIcon: widget.leftIcon,
            removeOverLay: reverseAnimation,
            rightIcon: widget.rightIcon,
            topIcon: widget.topIcon,
            splashColor: widget.splashColor,
            sizeAnimation: sizeAnimation,
            link: layerLink,
          );
        },
      );

      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
      forwardAnimation();
    }
  }

  @override
  void initState() {
    rotateAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: durationInMilliSeconds));

    rotationTween = Tween(begin: 0.0, end: pi);
    sizeTween = Tween(begin: 0.0, end: 1);

    sizeAnimation = sizeTween.animate(rotateAnimationController);
    rotatedAnimation = rotationTween.animate(rotateAnimationController);

    super.initState();
  }

  @override
  void dispose() {
    rotateAnimationController.dispose();
    super.dispose();
  }

  reverseAnimation() {
    if (isOverlayCreated) {
      forwardIconAnimation(pi, 2 * pi);
      forwardSizeAnimation(1, 0);
      Future.delayed(const Duration(milliseconds: durationInMilliSeconds), () {
        removeOverlay();
      });
    }
  }

  forwardIconAnimation(double begin, double end) {
    rotateAnimationController.reset();
    rotationTween.begin = begin;
    rotationTween.end = end;
    rotateAnimationController.forward();
  }

  forwardSizeAnimation(double begin, double end) {
    rotateAnimationController.reset();
    sizeTween.begin = begin;
    sizeTween.end = end;
    rotateAnimationController.forward();
  }

  forwardAnimation() {
    if (isOverlayCreated) {
      forwardIconAnimation(0, pi);
      forwardSizeAnimation(0, 1);
    }
  }

  animate() {
    if (!isOverlayCreated) {
      createOverLay();
    } else {
      reverseAnimation();
    }
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const Screen(
      title: "Screen Two",
    ),
    const Screen(
      title: "Screen Three",
    ),
    const Screen(
      title: "Screen Four",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //const size = Size(320, 480);
    final size = MediaQuery.of(context).size;
    print("Width :=> ${size.width}");
    print("Height :=> ${size.height}");
    return WillPopScope(
      onWillPop: () async {
        if (isOverlayCreated) {
          animate();
          return false;
        } else if (pageIndex.value != 0) {
          pageIndex.value = 0;
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ValueListenableBuilder(
            valueListenable: pageIndex,
            builder: (context, index, child) {
              return IndexedStack(
                index: index,
                children: screens,
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CompositedTransformTarget(
          link: layerLink,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 61.h,
                height: 61.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3.1.w),
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xFF1E594A),
                        Color(0xFF1E594A),
                        Color(0xFF044131),
                      ],
                      focal: Alignment.topCenter,
                      stops: [0, 0.8, 1],
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2.h),
                        color: Colors.grey,
                        spreadRadius: 1.r,
                        blurRadius: 6.r,
                      )
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: animate,
                    borderRadius: BorderRadius.circular(100.r),
                    child: Transform.scale(
                      scaleX: -1,
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: AnimatedBuilder(
                            animation: rotateAnimationController,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: rotatedAnimation.value,
                                child: SizedBox(
                                  width: 61.h - 3.1.h,
                                  height: 61.h - 3.1.h,
                                  child: const Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: CustomPaint(
          painter: CustomBottomPainter(shadowBlurOpacity: 0.3),
          child: SizedBox(
            width: size.width,
            height: 90.h,
            child: ValueListenableBuilder(
                valueListenable: pageIndex,
                builder: (context, index, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      navIcon("Home", Icons.home, 0),
                      navIcon("Search", Icons.search, 1),
                      SizedBox(
                        width: 60.w,
                      ),
                      navIcon("Favorite", Icons.favorite_outline, 2),
                      navIcon("Search", Icons.settings, 3),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Expanded navIcon(String label, IconData icon, int index) {
    final bool isSelectedIndex = pageIndex.value == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          pageIndex.value = index;
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          children: [
            15.verticalSpace,
            Icon(
              icon,
              color: isSelectedIndex
                  ? const Color(0xFF1F594A)
                  : const Color(0xFF858D89),
            ),
            4.verticalSpace,
            Text(
              label,
              style: TextStyle(
                  color: isSelectedIndex
                      ? const Color(0xFF1F594A)
                      : const Color(0xFF858D89),
                  fontSize: 12,
                  fontWeight:
                      isSelectedIndex ? FontWeight.w600 : FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class CustomBottomPainter extends CustomPainter {
  final Offset? cornerRadius;
  final double? notchYDip;
  final double? notchCornerRadiusX;
  final double? notchControlRadiusX;
  final double? notchHeight;
  final double? notchWidth;
  final double? shadowBlurRadius;
  final Color? shadowColor;
  final Color? navColor;
  final double? shadowBlurOpacity;
  final Offset? shadowShift;
  CustomBottomPainter({
    this.cornerRadius,
    this.notchYDip,
    this.notchCornerRadiusX,
    this.notchControlRadiusX,
    this.notchHeight,
    this.notchWidth,
    this.shadowBlurOpacity,
    this.shadowBlurRadius,
    this.shadowColor,
    this.navColor,
    this.shadowShift,
  });
  @override
  void paint(Canvas canvas, Size size) {
    if (size.height < 50.h) {
      throw Exception("Height must be greater than or equal to 50 pixels");
    }
    final double w = size.width;
    final double h = size.height;
    final double moveToX = cornerRadius?.dx ?? 20.w;
    final double moveToY = cornerRadius?.dy ?? 20.h;
    final double radiusYDip = notchYDip ?? 15.h;
    final double radiusX = notchCornerRadiusX ?? 15.w;
    final double notchCurveX = notchControlRadiusX ?? 40.w;
    final double notchDepthY = notchHeight ?? 50.h;
    final double notchDepthX = notchWidth ?? 25.w;

    final paint = Paint()..color = navColor ?? Colors.white;

    final path = Path()
      ..moveTo(moveToX, 0)
      ..lineTo(w * .5 - notchDepthY - radiusX, 0)
      ..quadraticBezierTo(
        w * .5 - notchDepthY + 5.w,
        0,
        w * .5 - notchCurveX,
        radiusYDip,
      )
      ..cubicTo(
        w * .5 - notchDepthX,
        notchDepthY,
        w * .5 + notchDepthX,
        notchDepthY,
        w * .5 + notchCurveX,
        radiusYDip,
      )
      ..quadraticBezierTo(
        w * .5 + notchDepthY - 5.w,
        0,
        w * .5 + notchCurveX + radiusX,
        0,
      )
      ..lineTo(w - moveToX, 0)
      ..quadraticBezierTo(w, 0, w, moveToY)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..lineTo(0, moveToY)
      ..quadraticBezierTo(0, 0, moveToX, 0)
      ..close();

    canvas.drawShadow(
      path.shift(shadowShift ?? const Offset(0, -5)),
      (shadowColor ?? Colors.grey).withOpacity(
        shadowBlurOpacity ?? 0.8.r,
      ),
      shadowBlurRadius ?? 5.0.r,
      true,
    );
    canvas.drawPath(path, paint);
    //canvas.drawShadow(path, Colors.grey,2.0,false);
    //canvas.drawColor(Colors.white, BlendMode.dstOut);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OverLayWidget extends StatelessWidget {
  final IconItem? leftIcon;
  final IconItem? topIcon;
  final IconItem? rightIcon;
  final Color? splashColor;
  final LayerLink link;
  final Animation<double> sizeAnimation;

  final Function()? removeOverLay;
  const OverLayWidget({
    super.key,
    this.leftIcon,
    this.rightIcon,
    this.splashColor,
    this.removeOverLay,
    this.topIcon,
    required this.sizeAnimation,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // const size = Size(320, 480);
    return SizedBox(
      width: size.width,
      height: size.height,
      // color: Colors.black12,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: removeOverLay,
            behavior: HitTestBehavior.translucent,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CompositedTransformFollower(
              link: link,
              followerAnchor: Alignment.bottomCenter,
              offset: Offset(0, 20.h),
              targetAnchor: Alignment.topCenter,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                      animation: sizeAnimation,
                      builder: (context, child) {
                        return SizedBox(
                          // width:getDynamicWidth(size.width),
                          //  width: 248,
                          //  height: 125,
                          width: getWidth(size.width),
                          height: getHeight(size.height),
                          child: LayoutBuilder(builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final height = constraints.maxHeight;
                            final wh = (width / 3) - 10.h;

                            return Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                /* <---------Custom clipped Shape with BackdropFilter-------> */
                                ClipPath(
                                  clipper: Clipper(Size(width, height)),
                                  child: Opacity(
                                    opacity: sizeAnimation.value,
                                    child: Container(
                                      width: width,
                                      height: height,
                                      color: const Color(0xFFDAE3E1),
                                      // color:
                                      //     const Color.fromARGB(31, 202, 199, 199),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 7.w,
                                          sigmaY: 7.h,
                                        ),
                                        child: SizedBox(
                                          width: width,
                                          height: height,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                /* <---------Left Icon Widget-------> */
                                Positioned(
                                  left: 95 - (90 * sizeAnimation.value),
                                  bottom: -10 + (15 * sizeAnimation.value),
                                  child: Opacity(
                                    opacity: sizeAnimation.value,
                                    child: IconsWidget(
                                      wh: wh,
                                      splashColor: splashColor,
                                      iconItem: leftIcon,
                                      closeOverLay: removeOverLay,
                                      animationValue: sizeAnimation.value,
                                    ),
                                  ),
                                ),
                                /* <---------Right Icon Widget-------> */
                                Positioned(
                                  right: 95 - (90 * sizeAnimation.value),
                                  bottom: -10 + (15 * sizeAnimation.value),
                                  child: Opacity(
                                    opacity: sizeAnimation.value,
                                    child: IconsWidget(
                                      wh: wh,
                                      splashColor: splashColor,
                                      iconItem: rightIcon,
                                      closeOverLay: removeOverLay,
                                      animationValue: sizeAnimation.value,
                                    ),
                                  ),
                                ),
                                /* <---------Top Icon Widget-------> */
                                Positioned(
                                  top: 105 - (100 * sizeAnimation.value),
                                  child: Opacity(
                                    opacity: sizeAnimation.value,
                                    child: IconsWidget(
                                      wh: wh,
                                      splashColor: splashColor,
                                      iconItem: topIcon,
                                      closeOverLay: removeOverLay,
                                      animationValue: sizeAnimation.value,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  double getHeight(double systemHeight) {
    double height = 120.0.h;
    if (systemHeight <= 480 || systemHeight < 520) {
      height = 110.h;
    } else if (systemHeight == 520 || systemHeight < 568) {
      height = 115.h;
    } else if (systemHeight == 568 || systemHeight < 667) {
      height = 140.h;
    } else if (systemHeight == 667 || systemHeight <= 720.0) {
      height = 140.h;
    } else if (systemHeight > 720.0 && systemHeight <= 850) {
      height = 115.h;
    } else if (systemHeight > 850.0 && systemHeight <= 900) {
      height = 110.h;
    } else if (systemHeight > 900) {
      height = 108.h;
    }
    return height;
  }

  double getDynamicWidth(double systemWidth) {
    double width = 250.0.w;
    if (systemWidth <= 320) {
      width = systemWidth - 150.w;
    } else if (systemWidth == 375.0) {
      width = systemWidth - 130.w;
    } else if (systemWidth > 375.0 && systemWidth <= 392) {
      width = systemWidth - 135.w;
    } else if (systemWidth > 392.0 && systemWidth <= 432.0) {
      width = systemWidth - 159.w;
    } else if (systemWidth > 432.0) {
      width = systemWidth - 162.w;
    }
    return width;
  }

  double getWidth(double systemWidth) {
    double width = 250.0.w;
    if (systemWidth <= 320) {
      width = systemWidth - 150.w;
    } else if (systemWidth == 375.0) {
      width = systemWidth - 130.w;
    } else if (systemWidth > 375.0 && systemWidth <= 392) {
      width = systemWidth - 135.w;
    } else if (systemWidth > 392.0 && systemWidth <= 432.0) {
      width = systemWidth - 159.w;
    } else if (systemWidth > 432.0) {
      width = systemWidth - 162.w;
    }
    return width;
  }
}

class IconsWidget extends StatelessWidget {
  final IconItem? iconItem;
  final double wh;
  final Color? splashColor;
  final double animationValue;
  final Function()? closeOverLay;
  const IconsWidget({
    super.key,
    this.iconItem,
    this.splashColor,
    this.closeOverLay,
    this.animationValue = 1,
    required this.wh,
  });

  final BoxDecoration getDecoration = const BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
    gradient: RadialGradient(
      colors: [
        Colors.white,
        Colors.white,
        Color(0xFFCFCFCF),
      ],
      focal: Alignment.topCenter,
      stops: [0, 0.92, 1],
    ),
    /* boxShadow: [
      BoxShadow(
        blurRadius: 2.r,
        offset: Offset(0, 4.h),
        blurStyle: BlurStyle.inner,
        color: Colors.transparent,
        spreadRadius: 2.r,
      ),
      BoxShadow(
        blurRadius: 2.r,
        offset: Offset(0, 4.h),
        blurStyle: BlurStyle.inner,
        color: Colors.grey.withOpacity(.10),
        spreadRadius: 1.r,
      ),
      BoxShadow(
        color: const Color.fromRGBO(0, 0, 0, 0.13),
        blurRadius: 5.r,
        offset: Offset(0, 3.h),
        blurStyle: BlurStyle.inner,
      )
    ],*/
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wh * animationValue,
      height: wh * animationValue,
      decoration: getDecoration,
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: wh * animationValue,
          height: wh * animationValue,
          child: InkWell(
            onTap: () {
              if (iconItem?.onTap != null) {
                iconItem?.onTap!();
              }
              if (closeOverLay != null) {
                closeOverLay!();
              }
            },
            borderRadius: BorderRadius.circular(100),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: iconItem == null
                      ? []
                      : [
                          SvgPicture.asset(
                            iconItem!.svg,
                            height: 24.w * animationValue,
                            width: 24.w * animationValue,
                          ),
                          SizedBox(
                            height: 18.h * animationValue,
                            child: Text(
                              iconItem!.title,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize:
                                      getFontSize(context.textScaleFactor) *
                                          animationValue,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1E594A)),
                            ),
                          ),
                        ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double getFontSize(double scaleFactor) {
    if (scaleFactor < 1.0) {
      return 13.0;
    } else if (scaleFactor == 1.0) {
      return 12.0;
    } else if (scaleFactor > 1.0 && scaleFactor <= 1.19) {
      return 11.0;
    } else if (scaleFactor >= 1.2 && scaleFactor <= 1.3) {
      return 10.0;
    } else if (scaleFactor > 1.3) {
      return 10.0;
    }
    return 12.0;
  }
}

extension TextScale on BuildContext {
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
}

class Clipper extends CustomClipper<Path> {
  final Size size;
  Clipper(this.size);
  @override
  Path getClip(OffsetBase clipSize) {
    final w = size.width;
    final h = size.height;
    final totalCirclesWidth = w / 3;

    final radius = (totalCirclesWidth / 2);
    final topCenter = Offset(w * .5, radius);
    final rightCenter = Offset(w - radius, size.height - radius);
    final leftCenter = Offset(radius, size.height - radius);

    final double lineX1 = topCenter.dx + radius * cos(5.8);
    final double lineY1 = topCenter.dy + radius * sin(5.8);

    final double lineX2 = rightCenter.dx + radius * cos(4.8);
    final double lineY2 = rightCenter.dy + radius * sin(4.8);

/*     final double lineX3 = rightCenter.dx + radius * cos(2.7);
    final double lineY3 = rightCenter.dy + radius * sin(2.7);
 */
    final double lineX4 = leftCenter.dx + radius * cos(pi - 2.7);
    final double lineY4 = leftCenter.dy + radius * sin(pi - 2.7);

/*     final double lineX5 = leftCenter.dx + radius * cos(pi - 4.8);
    final double lineY5 = leftCenter.dy + radius * sin(pi - 4.8); */

    final double lineX6 = topCenter.dx + radius * cos(pi - 5.8);
    final double lineY6 = topCenter.dy + radius * sin(pi - 5.8);

    var path = Path()
      ..moveTo(lineX1, lineY1)
      ..quadraticBezierTo(w * .71, h * .35, lineX2, lineY2)
      ..arcTo(
          Rect.fromCenter(
              center: rightCenter, height: radius * 2, width: radius * 2),
          4.8,
          pi + 1,
          false)
      //..lineTo(lineX3, lineY3)
      ..quadraticBezierTo(w * .6, h * .65, w * .5, radius * 2)
      ..quadraticBezierTo(w * .4, h * .65, lineX4, lineY4)
      ..arcTo(
          Rect.fromCenter(
              center: leftCenter, height: radius * 2, width: radius * 2),
          .45,
          4.3,
          false)
      ..quadraticBezierTo(w - w * .71, h * .35, lineX6, lineY6)
      ..arcTo(
          Rect.fromCenter(
              center: topCenter, height: radius * 2, width: radius * 2),
          pi - 5.8,
          2,
          false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final totalCirclesWidth = w / 3;

    final radius = (totalCirclesWidth / 2);
    final topCenter = Offset(w * .5, radius);
    final rightCenter = Offset(w - radius, size.height - radius);
    final leftCenter = Offset(radius, size.height - radius);

    final paint = Paint()
      ..color = const Color(0xFFCAC7C7).withOpacity(.31)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 1);

    final double lineX1 = topCenter.dx + radius * cos(5.8);
    final double lineY1 = topCenter.dy + radius * sin(5.8);

    final double lineX2 = rightCenter.dx + radius * cos(4.8);
    final double lineY2 = rightCenter.dy + radius * sin(4.8);

    // final double lineX3 = rightCenter.dx + radius * cos(2.7);
    // final double lineY3 = rightCenter.dy + radius * sin(2.7);

    final double lineX4 = leftCenter.dx + radius * cos(pi - 2.7);
    final double lineY4 = leftCenter.dy + radius * sin(pi - 2.7);

    // final double lineX5 = leftCenter.dx + radius * cos(pi - 4.8);
    // final double lineY5 = leftCenter.dy + radius * sin(pi - 4.8);

    final double lineX6 = topCenter.dx + radius * cos(pi - 5.8);
    final double lineY6 = topCenter.dy + radius * sin(pi - 5.8);

    var path = Path()
      ..moveTo(lineX1, lineY1)
      ..quadraticBezierTo(w * .71, h * .35, lineX2, lineY2)
      ..arcTo(
          Rect.fromCenter(
              center: rightCenter, height: radius * 2, width: radius * 2),
          4.8,
          pi + 1,
          false)
      //..lineTo(lineX3, lineY3)
      ..quadraticBezierTo(w * .6, h * .65, w * .5, radius * 2)
      ..quadraticBezierTo(w * .4, h * .65, lineX4, lineY4)
      ..arcTo(
          Rect.fromCenter(
              center: leftCenter, height: radius * 2, width: radius * 2),
          .45,
          4.3,
          false)
      ..quadraticBezierTo(w - w * .71, h * .35, lineX6, lineY6)
      ..arcTo(
          Rect.fromCenter(
              center: topCenter, height: radius * 2, width: radius * 2),
          pi - 5.8,
          2,
          false)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawCircle(
        topCenter, radius, paint..color = const Color(0xFF1F594A));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Screen extends StatelessWidget {
  final String title;
  const Screen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 1,
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
