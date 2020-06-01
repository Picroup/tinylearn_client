
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'GraphQL.dart';

GraphQL createGraphQL({ 
  @required String uri,
  @required GetToken getToken,
}) {
  assert(uri != null);
  assert(getToken != null);
  
  final HttpLink httpLink = HttpLink(
    uri: uri
  );

  final AuthLink authLink = AuthLink(
    getToken: () async {
      final token = await getToken();
      if (token == null || token.isEmpty) return '';
      return 'Bearer $token';
    }
  );

  final link = authLink.concat(httpLink);

  final _client = GraphQLClient(
    cache: InMemoryCache(),
    link: link,
  );
  
  return GraphQL(_client);
}
