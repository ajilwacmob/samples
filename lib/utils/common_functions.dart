import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samples/data/remote/api_error_types.dart';
import 'package:samples/utils/loader_states.dart';

Future<bool> isInternetAvailable() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

afterInit(Function function) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    function();
  });
}

String getErrorMessage(ApiErrorTypes types) {
  switch (types) {
    case ApiErrorTypes.connectionTimeout:
      return "Connection timeout";
    case ApiErrorTypes.sendTimeout:
      return "Send timeout";
    case ApiErrorTypes.receiveTimeout:
      return "Receive timout";
    case ApiErrorTypes.badCertificate:
      return "Bad certificate";
    case ApiErrorTypes.badResponse:
      return "Bad response";
    case ApiErrorTypes.cancel:
      return "Cancelled";
    case ApiErrorTypes.connectionError:
      return "Connection error";
    case ApiErrorTypes.unknown:
      return "Unknown";
    case ApiErrorTypes.unAuthorized:
      return "Unauthorized";
    case ApiErrorTypes.badRequest:
      return "Bad request";
    case ApiErrorTypes.internalServerError:
      return "Internal server error";
    case ApiErrorTypes.serviceUnavailable:
      return "Service unavailable";
    case ApiErrorTypes.notFound:
      return "Bad response";
    case ApiErrorTypes.jsonParsing:
      return "Json parsing error";
    case ApiErrorTypes.noInternet:
      return "No internet";
    case ApiErrorTypes.oops:
      return "Something went wrong";
  }
}


LoaderState handleResponseError(ApiErrorTypes errorType) {
  return switch (errorType) {
    ApiErrorTypes.cancel => LoaderState.error,
    ApiErrorTypes.noInternet => LoaderState.networkError,
    ApiErrorTypes.badCertificate => LoaderState.error,
    ApiErrorTypes.badResponse => LoaderState.error,
    ApiErrorTypes.connectionError => LoaderState.error,
    ApiErrorTypes.connectionTimeout => LoaderState.error,
    ApiErrorTypes.badRequest => LoaderState.error,
    ApiErrorTypes.jsonParsing => LoaderState.error,
    ApiErrorTypes.internalServerError => LoaderState.serverError,
    ApiErrorTypes.sendTimeout => LoaderState.error,
    ApiErrorTypes.notFound => LoaderState.error,
    ApiErrorTypes.oops => LoaderState.error,
    ApiErrorTypes.unAuthorized => LoaderState.error,
    ApiErrorTypes.serviceUnavailable => LoaderState.error,
    ApiErrorTypes.receiveTimeout => LoaderState.error,
    _ => LoaderState.error,
  };
}