import 'package:flutter/material.dart';
import 'package:samples/filter/view/widget/check_box_painter.dart';

class AnimatedCheckBoxTile extends StatefulWidget {
 final String itemName;
  const AnimatedCheckBoxTile({super.key,required this.itemName});

  @override
  State<AnimatedCheckBoxTile> createState() => _AnimatedCheckBoxTileState();
}

class _AnimatedCheckBoxTileState extends State<AnimatedCheckBoxTile>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;

  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return InkWell(
      onTap: () {
        isSelected = !isSelected;
        setState(() {});
        //  Navigator.push(context,
        //     CupertinoPageRoute(builder: (_) => const CheckBoxPainterScreen()));
      },
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFf13C9A2) : null,
                      border:
                          isSelected ? null : Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3)),
                  child: const Text(""),
                ),
                if (isSelected)
                  Positioned(
                      child: CustomPaint(
                    painter: CheckPainter(),
                    size: const Size(20, 20),
                  ))
              ],
            ),
            const SizedBox(
              width: 13,
            ),
             Text(widget.itemName)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
