
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ModelRequest {

  final GraphQLClient _client;

  ModelRequest(this._client);

  Future<Model> query<Model>({
    @required QueryOptions options,
    @required Model parse(dynamic data)
  }) async {
    final data = await _queryData(options);
    return data == null ? null : parse(data);
  }

  Future<Model> mutate<Model>({
    @required MutationOptions options,
    @required Model parse(dynamic data)
  }) async {
    final data = await _mutateData(options);
    return data == null ? null : parse(data);
  }

  Future<dynamic> _queryData(
    QueryOptions options
  ) async {
    final result = await _client.query(options);
    if (result.hasException) throw result.exception;
    return result.data;
  }

  Future<dynamic> _mutateData(
    MutationOptions options
  ) async {
    final result = await _client.mutate(options);
    if (result.hasException) throw result.exception;
    return result.data;
  }
}