import 'package:flutter/material.dart';

class TicketBookCustomPainterScreen extends StatefulWidget {
  const TicketBookCustomPainterScreen({super.key});

  @override
  State<TicketBookCustomPainterScreen> createState() =>
      _TicketBookCustomPainterScreenState();
}

class _TicketBookCustomPainterScreenState
    extends State<TicketBookCustomPainterScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: size.width,
          height: size.height * .3,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomPaint(
            painter: TicketPainter(),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "E Ticket",
                  style: TextStyle(color: Colors.white),
                )
              ]),
            ),
          ),
          // color: Colors.indigo,
        ),
      ),
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double innerWidth = size.width * .05;
    double innerHeight = size.height * .08;

    double y1Height = size.height * .2;
    double y2Height = size.height * .7;

    final painter = Paint()
      ..strokeWidth = 3
      ..shader = const LinearGradient(
        colors: [
          Colors.indigo,
          Colors.yellow,
          Color.fromARGB(255, 31, 145, 90),
          Colors.red,
          Colors.blue,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(
        Rect.fromLTRB(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke;
    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(w - innerWidth, 0);

    path.quadraticBezierTo(w, 0, w, innerHeight);
    path.lineTo(w, y1Height);

    path.lineTo(w - innerWidth, y1Height + innerHeight);
    path.lineTo(w - innerWidth, y2Height);
    path.lineTo(w, y2Height + innerHeight);

    path.lineTo(w, h - innerHeight);
    path.quadraticBezierTo(w, h, w - innerWidth, h);

    path.lineTo(innerWidth, h);
    path.quadraticBezierTo(0, h, 0, h - innerHeight);

    path.lineTo(0, h - innerHeight);
    path.lineTo(0, y2Height + innerHeight);
    path.lineTo(innerWidth, y2Height);
    path.lineTo(innerWidth, y1Height + innerHeight);
    path.lineTo(0, y1Height);

    path.lineTo(0, innerHeight);
    path.quadraticBezierTo(0, 0, innerWidth, 0);

    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
