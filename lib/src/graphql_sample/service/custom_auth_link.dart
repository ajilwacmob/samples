import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';

typedef RequestTransformer = FutureOr<Request> Function(Request request);

typedef OnException = FutureOr<String> Function(
  HttpLinkServerException exception,
);

/// Simple header-based authentication link that adds [headerKey]: [getToken()] to every request.
///
/// If a lazy or exception-based authentication link is needed for your use case,
/// implementing your own from the [gql reference auth link] or opening an issue.
///
/// [gql reference auth link]: https://github.com/gql-dart/gql/blob/1884596904a411363165bcf3c7cfa9dcc2a61c26/examples/gql_example_http_auth_link/lib/http_auth_link.dart
class CustomAuthLink extends _AsyncReqTransformLink {
  CustomAuthLink({
    required this.getToken,
    this.headerKey = 'Authorization',
  }) : super(requestTransformer: transform(headerKey, getToken));

  /// Authentication callback. Note – must include prefixes, e.g. `'Bearer $token'`
  final FutureOr<String?> Function() getToken;

  /// Header key to set to the result of [getToken]
  final String headerKey;

  static RequestTransformer transform(
    String headerKey,
    FutureOr<String?> Function() getToken,
  ) =>
      (Request request) async {
        final token = await getToken();
        return request.updateContextEntry<HttpLinkHeaders>(
          (headers) => HttpLinkHeaders(
            headers: <String, String>{
              ...headers?.headers ?? <String, String>{},
              if (token != null && token.isNotEmpty) headerKey: token,
            },
          ),
        );
      };
}

/// Version of [TransformLink] that handles async transforms
class _AsyncReqTransformLink extends Link {
  final RequestTransformer requestTransformer;

  _AsyncReqTransformLink({
    required this.requestTransformer,
  });

  @override
  Stream<Response> request(
    Request request, [
    NextLink? forward,
  ]) async* {
    final req = await requestTransformer(request);

    yield* forward!(req);
  }
}
