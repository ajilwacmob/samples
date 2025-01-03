import 'package:either_dart/either.dart';
import 'package:samples/data/remote/api_error_types.dart';
import 'package:samples/data/remote/http/http_requests.dart' as http;
import 'package:samples/src/videos_gallery/home/model/video_model.dart';
import 'package:samples/utils/app_config.dart';

abstract class VideoRepo {
  Future<Either<ResponseError, VideoModel>> getVideos(String? query);
}

class VideoRepoImplements extends VideoRepo {
  @override
  Future<Either<ResponseError, VideoModel>> getVideos(String? query) {
    final url = "${AppConstants.videoBaseUrl}&q=$query";
    return http
        .safe(http.getRequest(url: url))
        .thenRight(http.checkHttpStatus)
        .thenRight(http.parseJson)
        .mapRight((right) {
      return VideoModel.fromJson(right);
    });
  }
}
