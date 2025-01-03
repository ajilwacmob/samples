import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:samples/src/videos_gallery/home/model/video_model.dart';
import 'package:samples/src/videos_gallery/home/repo/video_repo.dart';
import 'package:samples/utils/loader_states.dart';

class VideoViewModel extends ChangeNotifier with VideoListLoaderState {
  late VideoRepo videoRepo;
  VideoViewModel(this.videoRepo);

  String errorMessage = '';

  List<Hit> videos = [];

  int nextPage = 1;
  int itemPerPage = 15;
  int totalVideosCount = 0;

  @override
  updateImageLoader(LoaderState state, bool isPaginating) {
    isPagePaginating = isPaginating;
    if (!isPaginating) {
      getVideoLoaderState = state;
    }
    notifyListeners();
  }

  Future<VideoModel?> getVideos({
    required String query,
    bool isPaginating = false,
  }) async {
    if (!isPaginating) {
      videos = [];
      nextPage = 1;
      itemPerPage = 15;
      totalVideosCount = 0;
    }

    updateImageLoader(LoaderState.loading, isPaginating);

    final finalQuery = "&q=$query&page=$nextPage&per_page=$itemPerPage";

    return await videoRepo.getVideos(finalQuery).fold((left) {
      errorMessage = left.message ?? "";
      debugPrint(errorMessage.toString());
      if (isPaginating) {
        isPagePaginating = false;
        totalVideosCount = videos.length;
        notifyListeners();
      } else {
        updateImageLoader(LoaderState.error, false);
      }
      return null;
    }, (right) {
      updateImageLoader(LoaderState.loaded, isPaginating);
      debugPrint(right.total.toString());
      totalVideosCount = (right.totalHits ?? 0);

      if ((right.hits ?? []).isNotEmpty) {
        final t = right.hits ?? [];
        videos = List.from(videos)..addAll(t);
        nextPage = (totalVideosCount != videos.length) ? nextPage + 1 : 1;
        updateImageLoader(LoaderState.hasData, false);
        return right;
      } else {
        updateImageLoader(LoaderState.noData, false);
        return null;
      }
    }).catchError((error) {
      debugPrint(error.toString());
      updateImageLoader(LoaderState.error, false);
      return null;
    });
  }

  update() {
    notifyListeners();
  }
}

mixin VideoListLoaderState {
  LoaderState getVideoLoaderState = LoaderState.initial;
  bool isPagePaginating = false;
  updateImageLoader(LoaderState state, bool isPaginating);
}
