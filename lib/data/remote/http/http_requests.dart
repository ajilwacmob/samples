import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:samples/data/remote/api_error_types.dart';
import 'package:samples/data/remote/api_exceptions.dart';
import 'package:samples/data/remote/http/http_functions.dart';
import 'package:samples/utils/common_functions.dart';

Future<Either<ResponseError, http.Response>> safe(
    Future<http.Response> request) async {
  try {
    return Right(await request);
  } on ApiExceptions catch (error) {
    return Left(ResponseError(key: error.errorType, message: error.message));
  } catch (e) {
    return Left(ResponseError(
        key: ApiErrorTypes.unknown, message: "Unknown Error : $e"));
  }
}

Either<ResponseError, http.Response> checkHttpStatus(http.Response response) {
  return getStatus(response);
}

Future<Either<ResponseError, dynamic>> parseJson(http.Response response) async {
  try {
    return Right(json.decode(response.body));
  } catch (e) {
    return const Left(ResponseError(
        key: ApiErrorTypes.jsonParsing, message: "Failed on json parsing"));
  }
}

Future<http.Response> getRequest({required String url}) async {
  if (!(await isInternetAvailable())) {
    throw ApiExceptions.noInternet();
  }
  dynamic response;
  try {
    final uri = Uri.parse(url);
    Map<String, String> parameters = <String, String>{
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    };
    response = await http
        .get(uri, headers: parameters)
        .timeout(const Duration(seconds: 30), onTimeout: () {
      throw ApiExceptions.oops();
    });
  } on Exception catch (error) {
    debugPrint(error.toString());
    if (error.toString().contains('SocketException')) {
      debugPrint("Error occurred while communicating with Server!");
    }
  }
  return response;
}
