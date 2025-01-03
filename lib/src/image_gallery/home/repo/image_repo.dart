import 'package:either_dart/either.dart';
import 'package:samples/data/remote/api_error_types.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/data/remote/http/http_requests.dart' as http;
import 'package:samples/utils/app_config.dart';

abstract class ImageRepo {
  Future<Either<ResponseError, ImageModel>> getImages(String? query);
}

class ImageRepoImplements extends ImageRepo {
  @override
  Future<Either<ResponseError, ImageModel>> getImages(String? query) {
   final url= "${AppConstants.baseUrl}?q=$query&per_page=51";
    return http
        .safe(http.getRequest(url: url))
        .thenRight(http.checkHttpStatus)
        .thenRight(http.parseJson)
        .mapRight((right) {
      return ImageModel.fromJson(right);
    });
  }
}
