import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samples/painter/loader_painter.dart';

class CommonImageWidget extends StatelessWidget {
  final String imgUrl;
  final double? height;
  final double? width;
  final double? radius;
  final bool showLoader;
  final bool showBorder;
  final double? borderWidth;
  final AlignmentGeometry? alignment;
  final List<Color>? loaderColors;
  const CommonImageWidget(
      {super.key,
      required this.imgUrl,
      this.height,
      this.radius,
      this.width,
      this.showLoader = true,
      this.borderWidth,
      this.showBorder = false,
      this.alignment,
      this.loaderColors});

  final String defaultimage =
      "https://cutewallpaper.org/24/image-placeholder-png/croppedplaceholderpng-%E2%80%93-osa-grappling.png";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        width: width ?? size.width,
        height: height ?? size.height * .35,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 0),
            border: showBorder
                ? Border.all(color: Colors.white, width: borderWidth ?? 2)
                : null,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              alignment: alignment ?? Alignment.center,
            ),
          ),
        ),
        placeholder: (context, url) => Center(
          child: showLoader
              ? CustomLoader(
                  gradeintColors: loaderColors,
                )
              : const SizedBox(),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 0),
            color: Colors.black38,
            border: Border.all(color: Colors.white, width: borderWidth ?? 2),
            image: DecorationImage(
              image: NetworkImage(
                defaultimage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
