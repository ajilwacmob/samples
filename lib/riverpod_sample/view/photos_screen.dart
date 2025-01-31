import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/common_widget/common_image_widget.dart';
import 'package:samples/common_widget/switch_state_widget.dart';
import 'package:samples/riverpod_sample/notifiers/photo_notifier.dart';
import 'package:samples/riverpod_sample/states/photo_state.dart';
import 'package:samples/riverpod_sample/view/photo_detail_screen.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/utils/common_functions.dart';

class PhotosScreen extends ConsumerStatefulWidget {
  const PhotosScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends ConsumerState<PhotosScreen> {
  final ScrollController _scrollController = ScrollController();

  final photosProvider =
      NotifierProvider<PhotoNotifier, PhotoState>(PhotoNotifier.new);

  @override
  void initState() {
    afterInit(_loadPhotos);
    _scrollListener();
    super.initState();
  }

  _scrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        final notifier = ref.watch(photosProvider);
        bool isPaginating = notifier.isPaginating;
        if (!isPaginating) {
          _loadPhotos(isPaginating: true);
        }
      }
    });
  }

  Future<void> _loadPhotos(
      {bool isPaginating = false, bool isReload = false}) async {
    PhotoNotifier photoNotifier = ref.read(photosProvider.notifier);
    return await photoNotifier.getPhotos(isPaginating, isReload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(
        builder: (_, ref, __) {
          final notifier = ref.watch(photosProvider);
          List<Hits> photos = notifier.photos ?? [];
          bool isPaginating = notifier.isPaginating;

          return Container(
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
            child: Column(
              children: [
                Expanded(
                  child: SwitchStateWidget(
                    loaderState: notifier.loaderState!,
                    errorMessage: notifier.errorMessage,
                    loadAgain: _loadPhotos,
                    isRequiredSystemHeight: true,
                    child: RefreshIndicator(
                      onRefresh: () =>
                          _loadPhotos(isPaginating: false, isReload: true),
                      child: Scrollbar(
                        controller: _scrollController,
                        child: GridView.builder(
                          itemCount: photos.length,
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final imageUrl = photos[index].largeImageURL ?? "";
                            final title = photos[index].tags ?? "";
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => PhotoDetailScreen(
                                      index: index,
                                      photos: photos,
                                    ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  CommonImageWidget(
                                    imgUrl: imageUrl,
                                    radius: 10,
                                    loaderColors: [
                                      Colors.black,
                                      Colors.black.withOpacity(0.5),
                                      Colors.white.withOpacity(0.8),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Positioned(
                                    left: 5,
                                    right: 5,
                                    bottom: 5,
                                    child: Text(
                                      title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 10,
                                      child: InkWell(
                                        onTap: () {
                                          if (photos[index].id != null) {
                                            ref
                                                .read(photosProvider.notifier)
                                                .deletePhoto(photos[index].id!);
                                          }
                                        },
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                if (isPaginating)
                  const LinearProgressIndicator(
                    color: Colors.red,
                    backgroundColor: Colors.white,
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
