import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/src/image_gallery/home/repo/image_repo.dart';
import 'package:samples/utils/loader_states.dart';

class ImageViewModel extends ChangeNotifier with ImageLoaderState {
  late ImageRepo imageRepo;
  ImageViewModel(this.imageRepo);

  String errorMessage = '';

  @override
  updateImageLoader(LoaderState state) {
    getImageLoaderState = state;
    notifyListeners();
  }

  Future<ImageModel?> getImages({required String query}) async {
    updateImageLoader(LoaderState.loading);
    return await imageRepo.getImages(query).fold((left) {
      errorMessage = left.message ?? "";
      debugPrint(errorMessage.toString());
      updateImageLoader(LoaderState.error);
      return null;
    }, (right) {
      updateImageLoader(LoaderState.loaded);
      debugPrint(right.total.toString());
  
        if (right.hits!.isNotEmpty) {
          updateImageLoader(LoaderState.hasData);
          return right;
        } else {
          updateImageLoader(LoaderState.noData);
          return null;
        }
    
    }).catchError((error) {
      debugPrint(error.toString());
      updateImageLoader(LoaderState.error);
      return null;
    });
  }


  update() {
    notifyListeners();
  }
}

mixin  ImageLoaderState {
  LoaderState getImageLoaderState = LoaderState.initial;
  updateImageLoader(LoaderState state);
 
}
