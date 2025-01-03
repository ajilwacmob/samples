import 'package:flutter/material.dart';

class CheckBoxPainterScreen extends StatefulWidget {
  const CheckBoxPainterScreen({super.key});

  @override
  State<CheckBoxPainterScreen> createState() => _CheckBoxPainterScreenState();
}

class _CheckBoxPainterScreenState extends State<CheckBoxPainterScreen> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: CustomPaint(
          painter: DiamonPainter(),
          size: Size(sw, sw),
        ),
      ),
    );
  }
}

class CheckPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * .1, size.height * .55)
      ..lineTo(size.width * .4, size.height * .8)
      ..lineTo(size.width * .85, size.height * .37)
      ..lineTo(size.width * .8, size.height * .25)
      ..lineTo(size.width * .4, size.height * .65)
      ..lineTo(size.width * .2, size.height * .48)
      ..lineTo(size.width * .1, size.height * .55);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DiamonPainter extends CustomPainter {
  //31D4D5

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * .5, 0)
      ..quadraticBezierTo(
          size.width * .6, size.height * .45, size.width, size.height * .5)
      ..quadraticBezierTo(
          size.width * .6, size.height * .6, size.width * .5, size.height)
      ..quadraticBezierTo(
          size.width * .35, size.height * .6, 0, size.height * .5)
      ..quadraticBezierTo(
          size.width * .35, size.height * .45, size.width * .5, 0);

    final paint = Paint()
      ..color = const Color(0xFF31D4D5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
