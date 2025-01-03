import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/music_module/view_model/music_view_model.dart';

class MusicDetailsScreen extends StatelessWidget {
  const MusicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<MusicViewModel>(builder: (_, viewModel, __) {
      final double height = viewModel.dynamicHeight;
      final double halfWidth = size.width / 2;
      final double imageCardSize = getMusicImageCardHeightAndWidth(height) / 2;
      final double totalLeftWidth = (halfWidth - imageCardSize);
      final double heightPercentage = ((height - 60.h) / (size.height));
      final double percentage = heightPercentage;
      final double leftPosition = totalLeftWidth * percentage;

      final double topHeight = 100 * percentage;

      /*  print("$percentage");
      print("$height");
      print("${size.height}"); */

      return GestureDetector(
        onPanUpdate: (details) {
          double height = (size.height - details.globalPosition.dy).abs();
          if (height <= 60) {
            return;
          } else if (height > size.height) {
            return;
          }
          viewModel.updateDynamicHeight = height;
          /* if (viewModel.isVerticalDragUp &&
              details.globalPosition.dy <= viewModel.currentHeight) {
            viewModel.updateVerticalDragUp = true;
          } */
          print(details.globalPosition.dy);
          // print(height);
        },
        onPanEnd: (details) {
          if (viewModel.dynamicHeight > 80) {
            viewModel.updateDynamicHeight = size.height;
          } else {
            viewModel.updateDynamicHeight = 60.h;
          }
          // Handle the touch release event here
        },

        // onVerticalDragUpdate: (details) {
        //   if (details.delta.dy > 0) {
        //     print("Down");
        //     print(details.globalPosition.dy);
        //     double height = (size.height - details.globalPosition.dy).abs();
        //     if (height <= 60) {
        //       return;
        //     } else if (height > size.height) {
        //       return;
        //     }
        //     viewModel.updateDynamicHeight = height;
        //     // print(height);
        //   } else if (details.delta.dy < 0) {
        //     print("Up");
        //   }
        // },
        // onVerticalDragEnd: (details){
        //   print(details.velocity.pixelsPerSecond);
        // },
        child: Container(
          height: viewModel.dynamicHeight,
          width: size.width,
          decoration: const BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 3,
                  spreadRadius: 1,
                  color: Colors.grey),
            ],
          ),
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
              ),
              AnimatedPositioned(
                top: topHeight,
                left: leftPosition,
                duration: const Duration(milliseconds: 20),
                child: InkWell(
                  onTap: () {
                    viewModel.updateDynamicHeight = size.height;
                  },
                  child: SingerImage(
                    dynamicHeight: viewModel.dynamicHeight,
                    percentage: percentage,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class SingerImage extends StatelessWidget {
  final double dynamicHeight;
  final double percentage;
  const SingerImage({
    super.key,
    required this.dynamicHeight,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final sw = getMusicImageCardHeightAndWidth(dynamicHeight);
    return Container(
      width: sw,
      height: sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r * percentage),
        image: const DecorationImage(
          image: NetworkImage(
              "https://globalnews.ca/wp-content/uploads/2023/01/GettyImages-1414522826.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

double getMusicImageCardHeightAndWidth(double dynamicHeight) {
  return dynamicHeight.clamp(30.h, 180.h).toDouble();
}

extension PrecisionPercentage on double {
  double toPreciseDecimal({int? subString}) {
    //String value = toStringAsFixed(2);
    //final splitValue = value.substring(0, subString ?? 3);
    // final decimalValue = double.parse(splitValue);
    return this;
  }
}
