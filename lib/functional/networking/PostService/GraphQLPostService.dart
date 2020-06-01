import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/functional/graphql/GraphQL.dart';
import 'package:tinylearn_client/functional/graphql_fragments/postFragment.dart';
import 'package:tinylearn_client/models/PostsData.dart';

import 'PostService.dart';

class GraphQLPostService extends PostService {

  final GraphQL _graphQL;

  GraphQLPostService(this._graphQL);

  @override
  Future<PostsData> posts() async {
    return await this._graphQL.query(
      options: QueryOptions(
        documentNode: gql('''
          query Posts {
            posts {
              $postBasicFragment 
            }
          }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      parse: (data) => PostsData.fromMap(data)
    );
  }

}