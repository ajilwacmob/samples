import 'package:flutter/material.dart';
import 'package:samples/common_widget/common_image_widget.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/utils/common_functions.dart';

class PhotoDetailScreen extends StatefulWidget {
  final int index;
  final List<Hits> photos;
  const PhotoDetailScreen({
    super.key,
    required this.index,
    required this.photos,
  });

  @override
  State<PhotoDetailScreen> createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  late PageController _pageController;

  final ValueNotifier<double> dxNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    afterInit(() {
      // precacheImages();
      dxNotifier.value = _pageController.page ?? widget.index.toDouble();
    });
    _pageController.addListener(() {
      dxNotifier.value = _pageController.page ?? 0.0;
    });
    super.initState();
  }

  precacheImages() {
    for (final photo in widget.photos) {
      precacheImage(NetworkImage(photo.largeImageURL ?? ""), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFff8787),
              Color(0xFFff9991),
              Color(0xFFfcb8a7),
              Color(0xFFfccab1),
              Color(0xFFfae8c5),
            ],
          ),
        ),
        child: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: dxNotifier,
              builder: (context, notifier, child) {
                return PageView.builder(
                  controller: _pageController,
                  itemCount: widget.photos.length,
                  itemBuilder: (context, index) {
                    final image = widget.photos[index];
                    final alignmentX =
                        ((notifier - index) * 1.8).clamp(-1.0, 1.0);

                    return Stack(
                      children: [
                        CommonImageWidget(
                          alignment: Alignment(alignmentX, 0.0),
                          imgUrl: image.largeImageURL ?? "",
                          height: size.height,
                          width: size.width,
                          loaderColors: [
                            Colors.black,
                            Colors.black.withOpacity(0.5),
                            Colors.white.withOpacity(0.8),
                          ],
                        ),
                        Positioned(
                          bottom: 20,
                          left: 16,
                          right: 16,
                          child: Container(
                            alignment: Alignment(alignmentX, 0.0),
                            child: Text(
                              image.tags ?? "",
                              maxLines: 5,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
