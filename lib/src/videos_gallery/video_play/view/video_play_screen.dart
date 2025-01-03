import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/painter/loader_painter.dart';
import 'package:samples/src/videos_gallery/home/model/video_model.dart';
import 'package:samples/src/videos_gallery/video_play/view_model/video_play_view_model.dart';
import 'package:samples/utils/common_functions.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  final Videos? videos;
  final int heroId;
  const VideoPlayScreen({
    super.key,
    this.videos,
    required this.heroId,
  });

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late final VideoPlayViewModel viewModel;

  @override
  void initState() {
    viewModel = VideoPlayViewModel(videos: widget.videos);
    afterInit(viewModel.initializeVideoPlayer);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.disposeVideoPlayer();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Video Player with Options'),
        ),
        body: Consumer<VideoPlayViewModel>(builder: (_, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              provider.isVideoInitialized
                  ? GestureDetector(
                      onTap: provider.hideControlls,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (provider.controller != null)
                            AspectRatio(
                              aspectRatio:
                                  provider.controller?.value.aspectRatio ?? 1.0,
                              child: VideoPlayer(provider.controller!),
                            ),

                          Align(
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                              duration: const Duration(seconds: 1),
                              opacity: provider.showControls ? 1 : 0,
                              child: InkWell(
                                onTap: provider.showControls
                                    ? null
                                    : provider.playPause,
                                child: Container(
                                  width: 60.w,
                                  height: 60.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black54,
                                  ),
                                  child: provider.isVideoPlaying
                                      ? const Icon(
                                          Icons.play_arrow,
                                          size: 40,
                                        )
                                      : const Icon(
                                          Icons.pause,
                                          size: 40,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: AnimatedOpacity(
                              duration: const Duration(seconds: 1),
                              opacity: provider.showControls ? 1 : 0,
                              child: AbsorbPointer(
                                absorbing: !provider.isVideoPlaying &&
                                    !provider.showControls,
                                child: VideoProgressIndicator(
                                  provider.controller!,
                                  allowScrubbing: true,
                                  colors: const VideoProgressColors(
                                    playedColor: Colors.red,
                                    backgroundColor: Colors.grey,
                                    bufferedColor: Colors.lightBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Progress Indicator
                        ],
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.sizeOf(context).height * .6,
                      child: const Center(
                        child: CustomLoader(),
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
