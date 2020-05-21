import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/functional/graphql/ModelRequest.dart';
import 'package:tinylearn_client/models/PostsData.dart';

import 'PostService.dart';

class GraphQLPostService extends PostService {

  final ModelRequest _modelRequest;

  GraphQLPostService(this._modelRequest);

  @override
  Future<PostsData> posts() async {
    return await this._modelRequest.query(
      options: QueryOptions(
        documentNode: gql('''
          query Posts {
            posts {
              id
              content
              created
            }
          }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      parse: (data) => PostsData.fromMap(data)
    );
  }

}