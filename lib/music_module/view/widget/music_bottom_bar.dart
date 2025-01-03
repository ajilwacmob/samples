import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/music_module/view/widget/music_details_screen.dart';
import 'package:samples/music_module/view_model/music_view_model.dart';

class MusicBottomBar extends StatelessWidget {
  const MusicBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MusicViewModel, bool>(
      selector: (_, selector) => selector.isOnceUserTappedTheMusic,
      builder: (context, isOnceUserTappedTheMusic, child) {
        return Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Visibility(
            visible: isOnceUserTappedTheMusic,
            child: const MusicDetailsScreen(),
          ),
        );
      },
    );
  }
}
