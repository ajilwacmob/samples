import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/music_module/view_model/music_view_model.dart';
import 'package:tuple/tuple.dart';

class MusicBottomNavBar extends StatelessWidget {
   MusicBottomNavBar({super.key});
  final double bottomNavigationBarHeight = 60.h;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Selector<MusicViewModel, Tuple2<double, int>>(
        selector: (_, selector) =>
            Tuple2(selector.dynamicHeight, selector.currentIndex),
        builder: (context, value, child) {
          final double height = value.item1;
          final double navHeight = _navBarHeight(height).toDouble();
         // final double opacity = _getNavOpacity(navHeight).toDouble();
          final viewModel = context.read<MusicViewModel>();
          return Container(
            //color: Colors.red.withOpacity(opacity),
            width: size.width,
            height: navHeight,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  navIcon("Home", Icons.home_outlined, 0, viewModel),
                  navIcon("Favorite", Icons.favorite_outline, 1, viewModel),
                  navIcon("Search", Icons.search, 2, viewModel),
                  navIcon(
                      "Chat", Icons.mark_chat_unread_outlined, 3, viewModel),
                  navIcon("Settings", Icons.settings_outlined, 4, viewModel),
                ],
              ),
            ),
          );
        });
  }

  double _getNavOpacity(double navHeight) {
    return (navHeight / bottomNavigationBarHeight).clamp(0.0, 1.0);
  }

  double _navBarHeight(double height) {
    return height >= bottomNavigationBarHeight
        ? (bottomNavigationBarHeight - height + bottomNavigationBarHeight) >=
                0.0
            ? (bottomNavigationBarHeight - height + bottomNavigationBarHeight)
            : 0.0
        : 0.0;
  }

  Expanded navIcon(
      String label, IconData icon, int index, MusicViewModel viewModel) {
    final bool isSelectedIndex = viewModel.currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          viewModel.updateCurrentIndex = index;
        },
        borderRadius: BorderRadius.circular(22.r),
        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
