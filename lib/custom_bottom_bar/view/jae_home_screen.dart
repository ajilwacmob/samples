import 'package:flutter/material.dart';


class JAEHomeScreen extends StatefulWidget {
  const JAEHomeScreen({super.key});

  @override
  State<JAEHomeScreen> createState() => _JAEHomeScreenState();
}

class _JAEHomeScreenState extends State<JAEHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [   
          SizedBox(
            width: double.maxFinite,
            height: 100,
            child: CustomPaint(
              painter: CustomNavClipper(),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 70,
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        // shadowColor: Colors.black,
        elevation: 20,
        shape: CustomNotchedShape(),
        notchMargin: 12,
        child: SizedBox(
          height: 60,
        ),
      ),
    );
  }
}

class CustomNavClipper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double height = 40;

    var paint = Paint()..color = Colors.red;
    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * .33, 0)
      ..quadraticBezierTo(size.width * .4, 0, size.width * .42, 14)
      //
      ..quadraticBezierTo(size.width * .45, height, size.width * .5, height)
      //
      ..quadraticBezierTo(size.width * .55, height, size.width * .58, 14)

      //
      ..quadraticBezierTo(size.width * .6, 0,
          size.width * .5 + (size.width * .5 - size.width * .33), 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomNotchedShape extends NotchedShape {
  /// Creates a [CustomNotchedShape].
  ///
  /// The same object can be used to create multiple shapes.
  const CustomNotchedShape();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    double height = 28;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(host.width * .3, 0)
      ..quadraticBezierTo(host.width * .38, 0, host.width * .42, 14)
      //
      ..quadraticBezierTo(host.width * .45, height, host.width * .5, height)
      //
      ..quadraticBezierTo(host.width * .55, height, host.width * .58, 14)

      //
      ..quadraticBezierTo(host.width * .62, 0,
          host.width * .5 + (host.width * .5 - host.width * .3), 0)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}
