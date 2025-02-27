import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:samples/src/graphql_sample/service/custom_auth_link.dart';

class AppConfig {
  static const String baseUrl = "";
  static String? accessToken;
}

class GraphQLClientConfiguration {
  //init
  GraphQLClientConfiguration._privateConstructor();

  static final GraphQLClientConfiguration _instance =
      GraphQLClientConfiguration._privateConstructor();

  static GraphQLClientConfiguration get instance => _instance;
  static GraphQLClient? _graphClient;

  static GraphQLClient? get graphQL => _graphClient;

  //config
  Future<bool> config(
      {String bearerToken = '',
      BuildContext? context,
      String store = '',
      bool initial = false}) async {
    _showQueryCalls(
        "GraphQl initialized with token as-->$bearerToken and URL as ${AppConfig.baseUrl}graphql");
    if (initial) {
      await initHiveForFlutter();
    }
    final HttpLink httpLink = HttpLink(
      '${AppConfig.baseUrl}graphql',
    );

    final CustomAuthLink authLink = CustomAuthLink(getToken: () async {
      String token = bearerToken.isNotEmpty
          ? bearerToken
          : (AppConfig.accessToken ?? await _getToken());

      return token;
    });
    final Link link = authLink.concat(httpLink);
    _graphClient =
        GraphQLClient(cache: GraphQLCache(store: HiveStore()), link: link);
    return _graphClient != null ? true : false;
  }

  Future<String> _getToken() async {
    return "";
  }

  //query call
  Future<dynamic> query(String query) async {
    _showQueryCalls(" QUERY --> $query");
    try {
      final QueryResult resp = await _graphClient!
          .query(QueryOptions(
              document: gql(query), fetchPolicy: FetchPolicy.noCache))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw NetworkException.fromException(
            originalException: '',
            message: 'Check your internet connection',
            uri: Uri(path: '${AppConfig.baseUrl}graphql'),
            originalStackTrace: StackTrace.empty);
      });

      if (resp.exception != null && resp.data == null) {
        if (resp.exception!.graphqlErrors.isNotEmpty) {
          _showQueryCalls(
              " QUERY EXCEPTION--> ${resp.exception?.graphqlErrors[0].message}");

          return <String, dynamic>{
            'status': 'error',
            'message': resp.exception?.graphqlErrors[0].message ??
                'Something went wrong',
            'extensions': resp.exception?.graphqlErrors[0].extensions
          };
        } else {
          _showQueryCalls(
              " QUERY EXCEPTION--> ${resp.exception?.linkException?.originalException}");

          return <String, dynamic>{
            'status': 'error',
            'message': resp.exception?.linkException?.originalException ??
                'Something went wrong',
            'extensions': resp.exception?.graphqlErrors[0].extensions
          };
        }
      }

      return resp.data;
    } catch (error) {
      _showQueryCalls(" QUERY ERROR--> $error");

      return <String, dynamic>{
        'status': 'error',
        'message': 'Something went wrong',
        'extensions': null
      };
    }
  }

  //mutation call
  Future<dynamic> mutation(String query,
      {Map<String, dynamic>? variables}) async {
    try {
      _showQueryCalls(" MUTATION --> $query");

      final QueryResult resp = await _graphClient!
          .mutate(MutationOptions(
              document: gql(query),
              fetchPolicy: FetchPolicy.noCache,
              variables: variables ?? {},
              errorPolicy: ErrorPolicy.all))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw NetworkException.fromException(
            originalException: '',
            message: 'Check your internet connection',
            uri: Uri(path: '${AppConfig.baseUrl}graphql'),
            originalStackTrace: StackTrace.empty);
      });

      if (resp.exception != null) {
        if (resp.exception!.graphqlErrors.isNotEmpty) {
          _showQueryCalls(
              " MUTATION EXCEPTION--> ${resp.exception?.graphqlErrors[0].message}");

          return <String, dynamic>{
            'status': 'error',
            'message': resp.exception!.graphqlErrors[0].message,
            'extensions': resp.exception?.graphqlErrors[0].extensions
          };
        } else {
          _showQueryCalls(
              " MUTATION EXCEPTION--> ${resp.exception?.linkException?.originalException}");

          return <String, dynamic>{
            'status': 'error',
            'message': resp.exception?.linkException?.originalException ??
                'Something went wrong',
            'extensions': resp.exception?.graphqlErrors[0].extensions
          };
        }
      }
      return resp.data;
    } catch (error) {
      _showQueryCalls(" MUTATION ERROR--> $error");

      return <String, dynamic>{
        'status': 'error',
        'message': 'Something went wrong',
        'extensions': null
      };
    }
  }

  // query print
  void _showQueryCalls(dynamic message) {
    debugPrint(message);
  }
}

typedef GetToken = FutureOr<String> Function();
typedef GetStoreCode = FutureOr<String> Function();
