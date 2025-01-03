import 'package:flutter/foundation.dart';
import 'package:samples/src/videos_gallery/home/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayViewModel extends ChangeNotifier with VideoPlayStates {
  VideoPlayViewModel({this.videos});

  final Videos? videos;

  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;

  void initializeVideoPlayer() {
    updateVideoInitializeState(false);
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(videos?.small?.url ?? ""),
    )..initialize().then((_) {
        updateVideoInitializeState(_controller?.value.isInitialized ?? false);
        _controller?.setLooping(true);
        _controller?.setVolume(0);
        playPause();
        hideControlls();
        notifyListeners();
      });
  }

  void startAutoHideTimer() {
    // if (!isVideoPlaying) {
    //   updateControlsState(true);
    // } else {
    //   updateControlsState(false);
    // }
  }

  hideControlls() {
    if (isVideoPlaying) {
      updateControlsState(true);
      Future.delayed(const Duration(seconds: 2), () {
        updateControlsState(false);
      });
      return;
    } else {
      updateControlsState(true);
      return;
    }
  }

  playPause() {
    if (isVideoPlaying) {
      _controller?.pause();
      updateVideoPlayingState(false);
    } else {
      _controller?.play();
      updateVideoPlayingState(true);
    }
  }

  disposeVideoPlayer() {
    _controller?.dispose();
  }

  @override
  updateVideoInitializeState(bool value) {
    isVideoInitialized = value;
    notifyListeners();
  }

  @override
  updateVideoPlayingState(bool value) {
    isVideoPlaying = value;
    notifyListeners();
  }

  @override
  updateControlsState(bool value) {
    showControls = value;
    notifyListeners();
  }
}

mixin VideoPlayStates {
  bool isVideoInitialized = false;
  bool isVideoPlaying = false;
  bool showControls = false;

  updateVideoInitializeState(bool value);
  updateVideoPlayingState(bool value);
  updateControlsState(bool value);
}
