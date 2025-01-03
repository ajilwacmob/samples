import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusicViewModel extends ChangeNotifier {
  double dynamicHeight = 60.h;
  double currentHeight = 60.h;
  int currentIndex = 0;
  bool isOnceUserTappedTheMusic = true;

  bool isVerticalDragUp = true;

  set updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  set updateDynamicHeight(double height) {
    dynamicHeight = height;
    notifyListeners();
  }

  set updateCurrentHeight(double height) {
    currentHeight = height;
    notifyListeners();
  }

  set updateVerticalDragUp(bool value) {
    isVerticalDragUp = value;
    notifyListeners();
  }

}
