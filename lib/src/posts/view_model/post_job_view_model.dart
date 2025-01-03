import 'package:flutter/foundation.dart';
import 'package:samples/src/posts/model/post_job_model.dart';

class PostJobViewModel extends ChangeNotifier {
  PostJobModel? jobModel;

  initData(dynamic json) {
    jobModel = PostJobModel.fromJson(json);
    notifyListeners();
  }
}