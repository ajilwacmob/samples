import 'package:flutter/foundation.dart';
import 'package:samples/src/posts/model/post_video_model.dart';

class PostVideoViewModel extends ChangeNotifier {
  PostVideoModel? jobModel;

  initData(dynamic json) {
    jobModel = PostVideoModel.fromJson(json);
    notifyListeners();
  }
}
