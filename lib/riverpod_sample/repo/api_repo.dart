import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/data/remote/api_error_types.dart';
import 'package:samples/data/remote/http/http_requests.dart';
import 'package:samples/utils/app_config.dart';

final apiRepoProvider = Provider<ApiRepo>((ref) {
  return ApiRepoImpl();
});

abstract class ApiRepo {
  Future<Either<ResponseError, dynamic>> fetchPhotos({required int page});
}

class ApiRepoImpl implements ApiRepo {
  @override
  Future<Either<ResponseError, dynamic>> fetchPhotos(
      {required int page}) async {
    const query =
        "beautiful+landscape+mountains+rivers+night sky+spaces+galaxys+snow+waterfall+newyork city";
    final url =
        "${AppConstants.baseUrl}&orientation=vertical&image_type=photo&per_page=20&page=$page&q=$query";
    return safe(getRequest(url: url))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) => right);
  }
}
