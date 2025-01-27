import 'package:flutter/material.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';

class PhotoDetailScreen extends StatefulWidget {
  final int index;
  final List<Hits> photos;
  const PhotoDetailScreen(
      {super.key, required this.index, required this.photos});

  @override
  State<PhotoDetailScreen> createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  late PageController _pageController;

  final ValueNotifier<double> dxNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    _pageController.addListener(() {
      dxNotifier.value = _pageController.page ?? 0.0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image.largeImageURL ?? ""),
                        fit: BoxFit.cover,
                        alignment: Alignment(alignmentX, 0.0),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
