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
    final url = "${AppConstants.baseUrl}&per_page=20&page=$page";
    return safe(getRequest(url: url))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) => right);
  }
}
