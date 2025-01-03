import 'dart:math';

import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  final Duration? duration;
  final Size? size;
  final double? strokewidth;
  final List<Color>? gradeintColors;

  const CustomLoader(
      {super.key,
      this.duration,
      this.size,
      this.strokewidth,
      this.gradeintColors});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        lowerBound: 0,
        upperBound: 2 * pi,
        duration: widget.duration ?? const Duration(milliseconds: 200),
        vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: animationController.value,
            child: CustomPaint(
              painter: LoaderPainter(
                gradeintColors: widget.gradeintColors,
                strokeWidth: widget.strokewidth,
              ),
              size: widget.size ?? const Size(30, 30),
            ),
          );
        },
      ),
    );
  }
}

class LoaderPainter extends CustomPainter {
  final double? strokeWidth;
  final List<Color>? gradeintColors;

  LoaderPainter({
    this.gradeintColors,
    this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    final paint = Paint()
      ..shader = SweepGradient(
              colors: gradeintColors ??
                  [
                    Colors.white.withOpacity(0.1),
                    const Color(0xFFF13005),
                    const Color(0xFFF13005),
                  ],
              endAngle: 5.9,
              startAngle: 0.16)
          .createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 3;

    canvas.drawArc(rect, 0.16, 5.9, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
