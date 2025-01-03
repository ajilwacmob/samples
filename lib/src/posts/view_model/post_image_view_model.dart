import 'package:flutter/foundation.dart';
import 'package:samples/src/posts/model/post_image_model.dart';

class PostImageViewModel extends ChangeNotifier {
  PostImageModel? imageModel;

  initData(dynamic json) {
    imageModel = PostImageModel.fromJson(json);
    notifyListeners();
  }
}
