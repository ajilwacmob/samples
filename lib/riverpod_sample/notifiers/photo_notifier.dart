import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/riverpod_sample/models/photo_model.dart';
import 'package:samples/riverpod_sample/repo/api_repo.dart';
import 'package:samples/riverpod_sample/states/photo_state.dart';
import 'package:samples/utils/common_functions.dart';
import 'package:samples/utils/loader_states.dart';

class PhotoNotifier extends Notifier<PhotoState> {
  //// This is the provider that will be used in the consumer widget
  Future<void> getPhotos(WidgetRef ref, bool isPaginating) async {
    if (isPaginating) {
      updateState(PhotoState(
        isPaginating: isPaginating,
        loaderState: LoaderState.loaded,
      ));
    } else {
      updateState(PhotoState(
        isPaginating: false,
        photos: const [],
        loaderState: LoaderState.loading,
      ));
    }
    await ref.read(apiRepoProvider).fetchPhotos().fold(
      (left) {
        LoaderState loaderState = handleResponseError(left.key);
        updateState(PhotoState(
            loaderState: loaderState,
            errorMessage: left.message,
            isPaginating: false,
            photos: const []));
      },
      (right) {
        if (right is List) {
          if (right.isNotEmpty) {
            List<Photo> photos = right.map((e) => Photo.fromJson(e)).toList();
            updateState(PhotoState(
              loaderState: LoaderState.loaded,
              isPaginating: false,
              photos: [...state.photos ?? [], ...photos],
            ));
          } else {
            updateState(PhotoState(
              loaderState: LoaderState.noData,
              isPaginating: false,
              errorMessage: "No photos found",
              photos: const [],
            ));
          }
        }
      },
    ).catchError((e) {
      updateState(PhotoState(
        loaderState: LoaderState.serverError,
        errorMessage: e.toString(),
        isPaginating: false,
        photos: const [],
      ));
    });
  }

  updateState(PhotoState photoState) {
    state = state.copyWith(
      photos: photoState.photos,
      isPaginating: photoState.isPaginating,
      loaderState: photoState.loaderState,
      errorMessage: photoState.errorMessage,
    );
  }

  deletePhoto(int id) {
    List<Photo> photos = state.photos ?? [];
    photos.removeWhere((element) => element.id == id);
    updateState(PhotoState(
      photos: photos,
      isPaginating: false,
      loaderState: LoaderState.loaded,
    ));
  }

  @override
  build() {
    return PhotoState(
      photos: const [],
      isPaginating: false,
      loaderState: LoaderState.loading,
      errorMessage: null,
    );
  }
}
