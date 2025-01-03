import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<void> getNetworkImageDimensions(String imageUrl) async {
  final http.Response response = await http.get(Uri.parse(imageUrl));
  final Uint8List bytes = response.bodyBytes;
  print(bytes.toString());
  final ui.Image image = await decodeImageFromList(bytes);
  print('Width: ${image.width}, Height: ${image.height}');
}

class CommonPostImage extends StatefulWidget {
  final List<String> images;
  const CommonPostImage({
    super.key,
    required this.images,
  });

  @override
  State<CommonPostImage> createState() => _CommonPostImageState();
}

class _CommonPostImageState extends State<CommonPostImage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.images.isEmpty) {
      return const SizedBox.shrink();
    } else if (widget.images.length == 1) {
      return SingleImage(url: widget.images.first);
    } else if (widget.images.length == 2) {
      return TwoImage(images: widget.images);
    } else if (widget.images.length > 2) {
      return MoreImages(images: widget.images);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class SingleImage extends StatelessWidget {
  final String? url;
  const SingleImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.width * .8,
      color: Colors.black,
      margin: EdgeInsets.only(top: 10.h),
      child: NetworkImageWidget(
        url: url ?? "",
        height: size.width,
        width: size.width,
      ),
    );
  }
}

class TwoImage extends StatelessWidget {
  final List<String> images;
  const TwoImage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.width * .8,
      color: Colors.black,
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        children: [
          Expanded(
            child: NetworkImageWidget(
              url: images.first,
              width: size.width * .5,
              height: size.width,
            ),
          ),
          2.horizontalSpace,
          Expanded(
            child: SizedBox(
              width: size.width * .5,
              child: NetworkImageWidget(
                url: images.last,
                height: size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoreImages extends StatefulWidget {
  final List<String> images;
  const MoreImages({super.key, required this.images});

  @override
  State<MoreImages> createState() => _MoreImagesState();
}

class _MoreImagesState extends State<MoreImages>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.width * .8,
      color: Colors.black,
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        children: [
          NetworkImageWidget(
            url: widget.images.first,
            height: size.width,
            width: size.width * .65,
          ),
          2.horizontalSpace,
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: NetworkImageWidget(
                    url: widget.images[1],
                    width: size.width * .5,
                  ),
                ),
                2.verticalSpace,
                Expanded(
                  child: NetworkImageWidget(
                    url: widget.images[2],
                    width: size.width * .5,
                  ),
                ),
                if (widget.images.length > 3) 2.verticalSpace,
                if (widget.images.length > 3)
                  Expanded(
                    child: Stack(
                      children: [
                        NetworkImageWidget(
                          width: size.width * .5,
                          url: widget.images[3],
                        ),
                        if (widget.images.length > 4)
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black45,
                            ),
                            child: Text(
                              "${widget.images.length - 4}+",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NetworkImageWidget extends StatefulWidget {
  final String? url;
  final double? width;
  final double? height;
  const NetworkImageWidget({
    super.key,
    this.url,
    this.height,
    this.width,
  });

  @override
  State<NetworkImageWidget> createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
       // borderRadius: BorderRadius.circular(6),
        image: widget.url != null
            ? DecorationImage(
                image: NetworkImage(widget.url!),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
