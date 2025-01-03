import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/src/image_gallery/home/repo/image_repo.dart';
import 'package:samples/utils/loader_states.dart';

class DetailsViewModel extends DetailsImplementation with ChangeNotifier   {
  bool mounted = true;

  ImageRepo imageRepo;

  DetailsViewModel(this.imageRepo);
  ImageModel? images;
  String errorMessage = '';
  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (mounted) {
      super.notifyListeners();
    }
  }

  Future<void> getImagesBySuggestions({required String query}) async {
    updateDetailsImageLoader(LoaderState.loading);
    await imageRepo.getImages(query).fold((responseError) {
      errorMessage = responseError.message ?? "";
      debugPrint(errorMessage.toString());
      updateDetailsImageLoader(LoaderState.error);
    }, (right) {
      updateDetailsImageLoader(LoaderState.loaded);
      debugPrint(right.total.toString());
     // if (right != null) {
        if (right.hits!.isNotEmpty) {
          images = right;
          updateDetailsImageLoader(LoaderState.hasData);
        } else {
          updateDetailsImageLoader(LoaderState.noData);
        }
      // } else {
      //   updateDetailsImageLoader(LoaderState.error);
      // }
    }).catchError((error) {
      debugPrint(error.toString());
      updateDetailsImageLoader(LoaderState.error);
    });
  }

  @override
  updateDetailsImageLoader(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}

abstract class DetailsImplementation {
  LoaderState loaderState = LoaderState.initial;
  updateDetailsImageLoader(LoaderState state);
}
