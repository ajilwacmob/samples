import 'dart:math';

import 'package:flutter/material.dart';

class InfographicPainterScreen extends StatefulWidget {
  const InfographicPainterScreen({super.key});

  @override
  State<InfographicPainterScreen> createState() =>
      _InfographicPainterScreenState();
}

class _InfographicPainterScreenState extends State<InfographicPainterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotatedAngleAnimation;
  late Tween<double> tween;
  double angle = 0;

  final customCubicCurve = const Cubic(.72, 1.08, .88, 1.11);

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    tween = Tween<double>(begin: 0, end: (2 * pi) * 5);
    rotatedAngleAnimation = tween.animate(
        CurvedAnimation(parent: animationController, curve: customCubicCurve));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        // onPanUpdate: (details) {
        //   details.localPosition.dx;
        //   setState(() {
        //     angle += details.globalPosition.dx / 5000;
        //   });
        // },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, value) {
                    return Transform.rotate(
                      angle: rotatedAngleAnimation.value,
                      child: Container(
                        width: size.width,
                        height: size.width,
                        color: Colors.black,
                        child: CustomPaint(
                          painter: InfographicPainter(
                              rotatedAngle: rotatedAngleAnimation.value),
                        ),
                      ),
                    );
                  }),
            ),
            Positioned(
                bottom: 100,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text("Rotate"),
                      onPressed: () {
                        print(rotatedAngleAnimation.value);
                        // rotatedAngleAnimation = Tween<double>(
                        //         begin: rotatedAngleAnimation.value,
                        //         end: ((2 * pi) * 6) +
                        //             rotatedAngleAnimation.value)
                        //     .animate(CurvedAnimation(
                        //         parent: animationController,
                        //         curve: customCubicCurve));
                        tween.begin = rotatedAngleAnimation.value;
                        tween.end = (2 * pi) * (Random().nextDouble() * 10);
                        animationController.reset();
                        animationController.forward();
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class InfographicPainter extends CustomPainter {
  final double rotatedAngle;
  InfographicPainter({required this.rotatedAngle});
  @override
  void paint(Canvas canvas, Size size) {
    print(rotatedAngle);
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.brown,
      Colors.indigo,
      Colors.teal,
      Colors.yellow,
      Colors.pink,
    ];

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * .175;
    final arcRadius = size.width * .19;
    final w = size.width / 2;
    //final h = size.height / 2;

    double totalRadius = 2 * pi;
    final sweepAngle = totalRadius / colors.length;

    final Rect rect = Rect.fromCircle(
      center: center,
      radius: arcRadius,
    );

    Paint arcPaint(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;

    for (int i = 0; i < colors.length; i++) {
      canvas.drawArc(
          rect, sweepAngle * i, sweepAngle, true, arcPaint(colors[i]));
    }

    final circlePaint = Paint()..color = Colors.white;

    canvas.drawCircle(center, radius, circlePaint);

    final xw = size.width * .4;
    final lx = size.width * .28;

    for (int i = 0; i < colors.length; i++) {
      final double x1 = center.dx + xw * cos(sweepAngle * i);
      final double y1 = center.dy + xw * sin(sweepAngle * i);

      final double lineX1 = center.dx + lx * cos(sweepAngle * i);
      final double lineY1 = center.dy + lx * sin(sweepAngle * i);

      drawTiangle(canvas, arcPaint(colors[i]), sweepAngle * i, sweepAngle,
          Offset(lineX1, lineY1), w * .13);
      canvas.drawCircle(Offset(x1, y1), w * .16, arcPaint(colors[i]));
      drawCircleWithShadow(canvas, w * .16, w * .13, Offset(x1, y1));
      drawTextPainter(canvas, i, Offset(x1, y1));
    }
  }

  drawCircleWithShadow(
    Canvas canvas,
    double radius1,
    double radius2,
    Offset center,
  ) {
    Path oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius1 + 40));
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 100);
    canvas.drawPath(oval, shadowPaint);

    Paint thumbPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius2, thumbPaint);
  }

  drawTiangle(
    Canvas canvas,
    Paint paint,
    double startAngle,
    double sweepAngle,
    Offset center,
    double radius,
  ) {
    var rec = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rec,
      startAngle - (sweepAngle / 2),
      sweepAngle,
      true,
      paint,
    );
  }

  drawTextPainter(Canvas canvas, int i, Offset offset) {
    const textStyle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final textSpan = TextSpan(
      text: '$i',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: offset.dx,
    );

    canvas.drawRotatedText(
        pivot: offset,
        textPainter: textPainter,
        angle: (360 * (pi / 180)) - rotatedAngle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

extension RotatedTextExt on Canvas {
  /// [angle] is in radians. Set `isInDegrees = true` if it is in degrees.
  void drawRotatedText({
    required Offset pivot,
    required TextPainter textPainter,
    TextPainter? superTextPainter,
    TextPainter? subTextPainter,
    required double angle,
    bool isInDegrees = false,
    Alignment alignment = Alignment.center,
  }) {
    //
    // Convert angle from degrees to radians
    angle = isInDegrees ? angle * pi / 180 : angle;

    textPainter.layout();
    superTextPainter?.layout();
    subTextPainter?.layout();

    // Calculate delta. Delta is the top left offset with reference
    // to which the main text will paint. The centre of the text will be
    // at the given pivot unless [alignment] is set.
    final w = textPainter.width;
    final h = textPainter.height;
    final delta = pivot.translate(
        -w / 2 + w / 2 * alignment.x, -h / 2 + h / 2 * alignment.y);
    //
    final supDelta =
        delta.translate(w, h - h * 0.6 - (superTextPainter?.size.height ?? 0));
    //
    final subDelta = delta.translate(w, h - (subTextPainter?.size.height ?? 0));

    // Rotate the text about pivot
    save();
    translate(pivot.dx, pivot.dy);
    rotate(angle);
    translate(-pivot.dx, -pivot.dy);
    textPainter.paint(this, delta);
    superTextPainter?.paint(this, supDelta);
    subTextPainter?.paint(this, subDelta);
    restore();
  }
}
