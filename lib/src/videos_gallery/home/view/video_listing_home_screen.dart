import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:samples/common_widget/switch_state_widget.dart';
import 'package:samples/src/videos_gallery/home/model/video_model.dart';
import 'package:samples/src/videos_gallery/home/repo/video_repo.dart';
import 'package:samples/src/videos_gallery/home/view/widget/video_card.dart';
import 'package:samples/src/videos_gallery/home/view_model/video_view_model.dart';
import 'package:samples/utils/common_functions.dart';
import 'package:samples/utils/loader_states.dart';
import 'package:tuple/tuple.dart';

class VideoListingHomeScreen extends StatefulWidget {
  const VideoListingHomeScreen({super.key});

  @override
  State<VideoListingHomeScreen> createState() => _VideoListingHomeScreenState();
}

class _VideoListingHomeScreenState extends State<VideoListingHomeScreen>
    with AutomaticKeepAliveClientMixin {
  late final VideoViewModel viewModel;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    viewModel = VideoViewModel(GetIt.instance<VideoRepo>());
    afterInit(_init);
    scrollController.addListener(scrollListener);
    super.initState();
  }

  _init() {
    viewModel.getVideos(query: "");
  }

  scrollListener() {
    if (scrollController.hasClients) {
      double scrollPosition = scrollController.position.pixels;
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      double percentage = (scrollPosition / maxScrollExtent) * 100;
      if (percentage > 90) {
        if (viewModel.videos.length != viewModel.totalVideosCount) {
          if (!viewModel.isPagePaginating) {
            viewModel.getVideos(query: "", isPaginating: true);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    super.build(context);
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        body: Selector<VideoViewModel,
            Tuple4<LoaderState, String?, List<Hit>, bool>>(
          selector: (_, selector) => Tuple4(
              selector.getVideoLoaderState,
              selector.errorMessage,
              selector.videos,
              selector.isPagePaginating),
          builder: (_, provider, __) {
            return Column(
              children: [
                Expanded(
                  child: SwitchStateWidget(
                    loaderState: provider.item1,
                    isRequiredSystemHeight: true,
                    loadAgain: _init,
                    errorMessage: provider.item2,
                    child: SizedBox(
                      width: size.width,
                      height: size.height,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          _init();
                        },
                        child: Scrollbar(
                          controller: scrollController,
                          interactive: true,
                          thumbVisibility: true,
                          child: GridView.builder(
                            itemCount: provider.item3.length,
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1,
                                    crossAxisCount: 3,
                                    childAspectRatio: 100 / 150),
                            itemBuilder: (_, index) {
                              Hit? video = provider.item3[index];
                              return VideoCard(videoData: video);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (provider.item4)
                  const LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
