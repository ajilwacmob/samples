import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class PainterScreen extends StatefulWidget {
  const PainterScreen({super.key});

  @override
  State<PainterScreen> createState() => _PainterScreenState();
}

class _PainterScreenState extends State<PainterScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier<int> indexChanger = ValueNotifier(4);

  late AnimationController animationController;

  final List<double> dataPoints = [
    0,
    40,
    100,
    30,
    150,
    20,
    200,
    120,
    280,
  ];

  late Timer timer;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        lowerBound: 0.0,
        upperBound: 1.0)
      ..forward();

    Future.delayed(const Duration(milliseconds: 3200), () {
      timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
        if (indexChanger.value == dataPoints.length - 1) {
          indexChanger.value = 0;
        } else {
          indexChanger.value++;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
          valueListenable: indexChanger,
          builder: (context, index, child) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * .9,
                    height: 300,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: CubicBezierCurvePainter(
                            stickyPoint: dataPoints[index],
                            dataPoints: dataPoints,
                            animation: animationController.value,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class CubicBezierCurvePainter extends CustomPainter {
  final double stickyPoint;
  final double animation;
  final List<double> dataPoints;

  CubicBezierCurvePainter({
    required this.stickyPoint,
    required this.dataPoints,
    required this.animation,
  });

  final rainbowColorTween = RainbowColorTween([
    const Color(0xFF2d1912),
    const Color(0xFFec7248),
    const Color(0xFFf5d12a),
    const Color(0xFF9de73c),
  ]);

  @override
  void paint(Canvas canvas, Size size) {
    /* <==================Gradient Rectangle Background==================> */
    final double dataPointSpacing = size.width / (dataPoints.length - 1);
    final double graphHeight = size.height * .8;
    final int index =
        dataPoints.indexWhere((element) => element == stickyPoint);
    final colorValue = dataPoints[index] / (size.height * .8);
    final double circleAlignX = (index) * dataPointSpacing;
    final double circleAlignY = graphHeight - dataPoints[index];

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    var heightFactor = dataPoints[index];
    var rect = Rect.fromCenter(
            center: Offset(circleAlignX, circleAlignY),
            width: 50 * animation,
            height: heightFactor + 30)
        .shift(Offset(0, (heightFactor / 2) - 15));

    final gr = LinearGradient(
        colors: [
          rainbowColorTween.lerp(colorValue).withOpacity(0.8),
          const Color(0xFF151614),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.0, 0.6]);
    const r = Radius.circular(25);
    const zeroRadius = Radius.zero;

    final roundedRect = RRect.fromLTRBAndCorners(
      rect.left,
      rect.top,
      rect.right,
      rect.bottom,
      topLeft: r,
      topRight: r,
      bottomLeft: zeroRadius,
      bottomRight: zeroRadius,
    );

    final rectPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..shader =
          gr.createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawRRect(roundedRect, rectPaint);

/* ========================= Line Curve Painter ========================== */
    final path = Path();
    path.moveTo(0, graphHeight);
    for (int i = 0; i < dataPoints.length - 1; i++) {
      final double x1 = (i * dataPointSpacing);
      final double y1 = (graphHeight - dataPoints[i]);

      final double x2 = (i + 1) * dataPointSpacing;
      final double y2 = graphHeight - dataPoints[i + 1];

      final double controlPointX1 = x1 + dataPointSpacing / 2;
      final double controlPointY1 = y1;

      final double controlPointX2 = x2 - dataPointSpacing / 2;
      final double controlPointY2 = y2;

      path.cubicTo(
        controlPointX1,
        controlPointY1,
        controlPointX2,
        controlPointY2,
        x2,
        y2,
      );
    }

    const gradient = LinearGradient(colors: [
      Color(0xFF2d1912),
      Color(0xFFec7248),
      Color(0xFFf5d12a),
      Color(0xFF9de73c),
    ], end: Alignment.topCenter, begin: Alignment.bottomCenter);

    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 4.0 * animation
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);

    /* ========================= Text Painter========================== */
    if (index != -1) {
      final textStyle = TextStyle(
          color: rainbowColorTween.lerp(colorValue),
          fontSize: 22 * animation,
          fontWeight: FontWeight.bold);
      final textSpan = TextSpan(text: '101', style: textStyle, children: [
        TextSpan(
          text: ' bpl',
          style: TextStyle(
              fontSize: 14 * animation,
              color: rainbowColorTween.lerp(colorValue).withOpacity(0.8)),
        )
      ]);
      final textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout();
      var offset = Offset(circleAlignY + 40, -circleAlignX - 10);
      canvas.save();
      canvas.rotate(1.55999);
      textPainter.paint(canvas, offset);
      canvas.restore();
    }

    /* <================Inner and Outer Circles==============> */
    var outerCirclePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
        Offset(circleAlignX, circleAlignY), 12 * animation, outerCirclePaint);
    var circlePaint = Paint()..color = rainbowColorTween.lerp(colorValue);
    canvas.drawCircle(
        Offset(circleAlignX, circleAlignY), 8 * animation, circlePaint);

    /* <======================== Draw bottom Lines======================> */

    final List<int> range = [300, 0, 400, 0, 500, 0, 600, 0, 700, 0, 800];
    linePainter(int i) => Paint()
      ..color = Colors.white
      ..strokeWidth = i.isEven ? 15 : 5;
    final linesWidth = size.width / (range.length - 1);
    for (int i = 0; i < range.length; i++) {
      canvas.drawLine(
          Offset(0 + (i * linesWidth * animation), size.height * .9),
          Offset(1 + (i * linesWidth * animation), size.height * .9),
          linePainter(i));
      if (i.isEven) {
        drawTextPainter(
            canvas, Offset((i * linesWidth - 5), size.height), range[i]);
      }
    }
  }

  drawTextPainter(Canvas canvas, Offset offset, int index) {
    final textStyle = TextStyle(
        color: Colors.white,
        fontSize: 10 * animation,
        fontWeight: FontWeight.bold);
    final textSpan = TextSpan(text: '$index', style: textStyle);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
