import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:samples/common_widget/common_image_widget.dart';
import 'package:samples/common_widget/switch_state_widget.dart';
import 'package:samples/src/image_gallery/details/view_model/details_view_model.dart';
import 'package:samples/src/image_gallery/download/view/image_full_view.dart';
import 'package:samples/src/image_gallery/download/view_model/download_view_model.dart';
import 'package:samples/src/image_gallery/download/widget/download_widget.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/src/image_gallery/home/repo/image_repo.dart';
import 'package:samples/src/image_gallery/home/view/image_home_screen.dart';
import 'package:samples/utils/common_functions.dart';
import 'package:samples/utils/loader_states.dart';
import 'package:tuple/tuple.dart';

class ImageDetailsScreen extends StatefulWidget {
  final Hits? imageData;
  final int heroId;
  const ImageDetailsScreen({
    super.key,
    this.imageData,
    required this.heroId,
  });

  @override
  State<ImageDetailsScreen> createState() => _ImageDetailsScreenState();
}

class _ImageDetailsScreenState extends State<ImageDetailsScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController scrollController = ScrollController();

  late DetailsViewModel detailsViewModel;

  OverlayEntry? overlayEntry;

  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void createOverlay() {
    final dp = context.read<DownLoadViewModel>();

    if (dp.isOverlayEnabled) {
      removeHighlightOverlay();
      assert(overlayEntry == null);

      overlayEntry = OverlayEntry(
        maintainState: true,
        builder: (BuildContext context) {
          return OverLayWidget(
            closeOverLay: removeHighlightOverlay,
          );
        },
      );
      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
    }
  }

  @override
  void initState() {
    detailsViewModel = DetailsViewModel(GetIt.instance<ImageRepo>());
    afterInit(_init);

    super.initState();
  }

  _init() {
    detailsViewModel.getImagesBySuggestions(
        query: "&q=${widget.imageData!.tags ?? ""}");
  }

  @override
  void dispose() {
    detailsViewModel.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    if (scrollController.hasClients &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      return scrollController
          .animateTo(0.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutExpo)
          .then((value) {
        return Future.delayed(
          const Duration(milliseconds: 200),
          () => Navigator.pop(context),
        ).then((value) => true);
      });
    } else {
      Navigator.pop(context);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: ChangeNotifierProvider.value(
        value: detailsViewModel,
        child: Scaffold(
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: size.height * .4,
                backgroundColor: Colors.transparent,
                collapsedHeight: 60,
                automaticallyImplyLeading: false,
                elevation: 0,
                title: SizedBox(
                  child: Row(
                    children: [
                      BackButton(onPressed: () {
                        onWillPop();
                      }),
                      CommonImageWidget(
                        imgUrl: widget.imageData?.userImageURL ?? "",
                        width: 50,
                        height: 50,
                        radius: 100,
                        showBorder: true,
                        borderWidth: 2.5,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.imageData?.user ?? ""),
                      const Spacer(),
                      SizedBox(
                        height: 25,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5)),
                            icon: const Icon(
                              Icons.arrow_downward,
                              size: 14,
                            ),
                            onPressed: () async {
                              var provider = context.read<DownLoadViewModel>();
                              // String url="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
                              // String fileName = "big buck bunny";
                              String url =
                                  widget.imageData?.largeImageURL ?? "";
                              String fileName =
                                  widget.imageData?.id?.toString() ?? "";

                              bool isFileExist = await provider.checkFileExists(
                                  url, fileName, true);
                              if (isFileExist) {
                                return;
                              }
                              if (!provider.isOverlayEnabled) {
                                provider.enbaleOverlay(true);
                                createOverlay();
                                provider.insertDownloadWidget(DownLoadWidget(
                                    fileName: fileName, url: url));
                              } else {
                                provider.insertDownloadWidget(DownLoadWidget(
                                    fileName: fileName, url: url));
                              }
                            },
                            label: const Text(
                              "Download",
                              style: TextStyle(fontSize: 12),
                            )),
                      ),
                    ],
                  ),
                ),
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: "${widget.heroId}",
                    child: CommonImageWidget(
                      imgUrl: widget.imageData?.largeImageURL ?? "",
                      width: size.width,
                      height: size.height * .4,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Selector<DetailsViewModel,
                    Tuple3<LoaderState, ImageModel?, String?>>(
                  selector: (_, selec) => Tuple3(
                      selec.loaderState, selec.images, selec.errorMessage),
                  builder: (_, provider, __) {
                    return SwitchStateWidget(
                      loaderState: provider.item1,
                      isRequiredSystemHeight: false,
                      loadAgain: _init,
                      errorMessage: provider.item3,
                      child: GridView.builder(
                        itemCount: provider.item2?.hits?.length,
                        // controller: scrollController,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                crossAxisCount: 3,
                                childAspectRatio: 100 / 150),
                        itemBuilder: (_, index) {
                          Hits? imageData = provider.item2?.hits?[index];
                          return ImageWidget(
                            imageData: imageData,
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
