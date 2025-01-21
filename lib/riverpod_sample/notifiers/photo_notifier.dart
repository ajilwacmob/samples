import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/riverpod_sample/repo/api_repo.dart';
import 'package:samples/riverpod_sample/states/photo_state.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/utils/common_functions.dart';
import 'package:samples/utils/loader_states.dart';

class PhotoNotifier extends Notifier<PhotoState> {
  //// This is the provider that will be used in the consumer widget
  Future<void> getPhotos(bool isPaginating) async {
    if (isPaginating) {
      updateState(PhotoState(
        isPaginating: isPaginating,
        loaderState: LoaderState
            .hasData, // don't need to show center loader when paginating, will show loader at the bottom
      ));
    } else {
      updateState(PhotoState(
        isPaginating: false,
        photos: const [],
        loaderState: LoaderState.loading,
        page: 1,
      ));
    }
    int page = state.page ?? 1;
    await ref.read(apiRepoProvider).fetchPhotos(page: page).fold(
      (left) {
        LoaderState loaderState = handleResponseError(left.key);
        updateState(PhotoState(
            loaderState: loaderState,
            errorMessage: left.message,
            isPaginating: false,
            page: 1,
            photos: const []));
      },
      (right) {
        updateState(PhotoState(
          loaderState: LoaderState.loaded,
          isPaginating: false,
        ));
        if (right["hits"] is List) {
          if (right.isNotEmpty) {
            List<Hits> photos = (right["hits"] as List<dynamic>)
                .map((e) => Hits.fromJson(e))
                .toList();
            int newPage = page + 1;
            updateState(PhotoState(
              loaderState: LoaderState.hasData,
              isPaginating: false,
              photos: [...state.photos ?? [], ...photos],
              page: newPage,
            ));
          } else {
            updateState(PhotoState(
              loaderState: LoaderState.noData,
              isPaginating: false,
              errorMessage: "No photos found",
              photos: const [],
              page: 1,
            ));
          }
        } else {
          updateState(PhotoState(
            loaderState: LoaderState.noData,
            isPaginating: false,
            errorMessage: "No photos found",
            photos: const [],
            page: 1,
          ));
        }
      },
    ).catchError((e) {
      updateState(PhotoState(
        loaderState: LoaderState.serverError,
        errorMessage: e.toString(),
        isPaginating: false,
        photos: const [],
        page: 1,
      ));
    });
  }

  updateState(PhotoState photoState) {
    state = state.copyWith(
      photos: photoState.photos,
      isPaginating: photoState.isPaginating,
      loaderState: photoState.loaderState,
      errorMessage: photoState.errorMessage,
      page: photoState.page,
    );
  }

  deletePhoto(int id) {
    List<Hits> photos = state.photos ?? [];
    photos.removeWhere((element) => element.id == id);
    updateState(PhotoState(photos: photos));
  }

  @override
  build() {
    return PhotoState(
      photos: const [],
      isPaginating: false,
      loaderState: LoaderState.loading,
      errorMessage: null,
      page: 1,
    );
  }
}
