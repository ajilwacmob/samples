import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/data/remote/api_error_types.dart';
import 'package:samples/data/remote/http/http_requests.dart';

final apiRepoProvider = Provider<ApiRepo>((ref) {
  return ApiRepoImpl();
});

abstract class ApiRepo {
  Future<Either<ResponseError, dynamic>> fetchPhotos();
}

class ApiRepoImpl implements ApiRepo {
  @override
  Future<Either<ResponseError, dynamic>> fetchPhotos() async {
    return safe(getRequest(url: "https://jsonplaceholder.typicode.com/photos"))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) => right);
  }
}
