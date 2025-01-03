import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (_, index) {
            return const AnimatedListTile();
          }),
    );
  }
}

class AnimatedListTile extends StatefulWidget {
  const AnimatedListTile({super.key});

  @override
  State<AnimatedListTile> createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<Offset>(
      begin: const Offset(100, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation.value,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r)),
            elevation: 5,
            child: ListTile(
              title: const Text("Animated List Tile"),
              subtitle: const Text("Animated sublist tile"),
              onTap: () {
                Navigator.pushNamed(context, "/next");
              },
            ),
          ),
        );
      },
    );
  }
}
