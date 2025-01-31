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
  final ValueNotifier<bool> hasPreviousNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hasNextNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    afterInit(_initialize);
    _addListener();
    super.initState();
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
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: hasPreviousNotifier,
              builder: (_, hasPrevious, child) {
                return hasPrevious
                    ? Positioned(
                        left: 10,
                        top: size.height * .7,
                        child: NextPrevious(
                          icon: Icons.arrow_back,
                          onTap: () {
                            if (hasPrevious) {
                              _pageController.previousPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOut);
                            }
                          },
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
            ValueListenableBuilder(
              valueListenable: hasNextNotifier,
              builder: (_, hasNext, child) {
                return hasNext
                    ? Positioned(
                        right: 10,
                        top: size.height * .7,
                        child: NextPrevious(
                          icon: Icons.arrow_forward,
                          onTap: () {
                            if (hasNext) {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOut);
                            }
                          },
                        ),
                      )
                    : const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }

  _initialize() {
    dxNotifier.value = _getIndex();
    hasNextNotifier.value = _getNext();
    hasPreviousNotifier.value = _getPrevious();
  }

  _addListener() {
    _pageController.addListener(() {
      dxNotifier.value = _getIndex();
      hasNextNotifier.value = _getNext();
      hasPreviousNotifier.value = _getPrevious();
    });
  }

  double _getIndex() {
    return _pageController.page ?? widget.index.toDouble();
  }

  bool _getPrevious() {
    return _pageController.page?.toInt() != 0;
  }

  bool _getNext() {
    return _pageController.page?.toInt() != (widget.photos.length - 1);
  }

  precacheImages() {
    for (final photo in widget.photos) {
      precacheImage(NetworkImage(photo.largeImageURL ?? ""), context);
    }
  }
}

class NextPrevious extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  const NextPrevious({
    super.key,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.4),
        ),
        child: Icon(icon),
      ),
    );
  }
}
