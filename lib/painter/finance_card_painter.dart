import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinanceCardPainterScreen extends StatefulWidget {
  const FinanceCardPainterScreen({super.key});

  @override
  State<FinanceCardPainterScreen> createState() =>
      _FinanceCardPainterScreenState();
}

class _FinanceCardPainterScreenState extends State<FinanceCardPainterScreen> {
  final grey = const Color(0xFF2E2F31);
  final green = const Color(0xFF2EE52C);
  final black = Colors.black;
  final blue = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finance App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.width,
            //color: blue,
            margin: EdgeInsets.all(16.w),
            child: CustomPaint(
              size: Size(
                size.width,
                size.width,
              ),
              painter: FinanceCardPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class FinanceCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const grey = Color(0xFF2E2F31);
    const green = Color(0xFF2EE52C);

    final padding = 20.w;
    final padding1 = 12.w;
    final curveX = 35.w;

    // card 1
    final card1X = size.width * .45;
    final card1Y = size.height * .45;

    /// card 2
    final card2X = size.width * .55;
    final card3X = size.width - padding;
    final card2Y = size.height * .55;
    final card3Y = size.height - padding;

    // draw first card
    final paint1 = Paint()..color = grey;
    final path1 = Path()
      ..moveTo(padding + curveX, padding)
      ..lineTo(card1X - curveX, padding)
      ..quadraticBezierTo(card1X, padding, card1X, padding + curveX)
      ..lineTo(card1X, card1Y - curveX)
      ..quadraticBezierTo(card1X, card1Y, card1X - curveX, card1Y)
      ..lineTo(padding + curveX, card1Y)
      ..quadraticBezierTo(padding, card1Y, padding, card1Y - curveX)
      ..lineTo(padding, padding + curveX)
      ..quadraticBezierTo(padding, padding, padding + curveX, padding);
    canvas.drawPath(path1, paint1);

    // draw second card
    final paint2 = Paint()..color = grey;
    final path2 = Path()
      ..moveTo(card2X + curveX, card2Y)
      ..lineTo(card3X - curveX, card2Y)
      ..quadraticBezierTo(card3X, card2Y, card3X, card2Y + curveX)
      ..lineTo(card3X, card3Y - curveX)
      ..quadraticBezierTo(card3X, card3Y, card3X - curveX, card3Y)
      ..lineTo(card2X + curveX, card3Y)
      ..quadraticBezierTo(card2X, card3Y, card2X, card3Y - curveX)
      ..lineTo(card2X, card2Y + curveX)
      ..quadraticBezierTo(card2X, card2Y, card2X + curveX, card2Y);
    canvas.drawPath(path2, paint2);

    // draw third green paint card
    final paint3 = Paint()..color = green;
    final path3 = Path()
      ..moveTo(size.width * .5 + curveX, padding1)
      ..lineTo(size.width - padding1 - curveX, padding1)
      ..quadraticBezierTo(size.width - padding1, padding1,
          size.width - padding1, padding1 + curveX)
      ..lineTo(size.width - padding1, size.height * .5 - curveX)
      ..quadraticBezierTo(size.width - padding1, size.height * .5,
          size.width - padding1 - curveX, size.height * .5)
      ..lineTo(size.width * .65, size.height * .5)
      ..quadraticBezierTo(
          size.width * .5, size.height * .5, size.width * .5, size.height * .65)
      ..lineTo(size.width * .5, size.height - padding1 - curveX)
      ..quadraticBezierTo(size.width * .5, size.height - padding1,
          size.width * .5 - curveX, size.height - padding1)
      ..lineTo(padding1 + curveX, size.height - padding1)
      ..quadraticBezierTo(padding1, size.height - padding1, padding1,
          size.height - padding1 - curveX)
      ..lineTo(padding1, size.height * .5 + curveX)
      ..quadraticBezierTo(
          padding1, size.height * .5, padding1 + curveX, size.height * .5)
      ..lineTo(size.width * .35, size.height * .5)
      ..quadraticBezierTo(size.width * .5, size.height * .5, size.width * .5,
          size.height * .5 - curveX)
      ..lineTo(size.width * .5, padding1 + curveX)
      ..quadraticBezierTo(
          size.width * .5, padding1, size.width * .5 + curveX, padding1);
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
