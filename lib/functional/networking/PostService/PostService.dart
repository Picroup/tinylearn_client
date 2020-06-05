import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/functional/graphql/GraphQL.dart';
import 'package:tinylearn_client/functional/graphql_fragments/postFragment.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/CreatePostInput.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/CursorInput.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/TimelineData.dart';


class PostService {

  final GraphQL _graphQL;

  PostService(this._graphQL);

  Future<TimelineData> timeline(CursorInput input) async {
    return await this._graphQL.query(
      options: QueryOptions(
        documentNode: gql('''
          query Timeline(\$take: Int!, \$cursor: String){
            timeline(input: { take: \$take, cursor: \$cursor }) {
              $cursorPostsFragment
            }
          }
        '''),
        variables: input.toMap(),
        fetchPolicy: FetchPolicy.networkOnly
      ),
      parse: (data) => TimelineData.fromMap(data),
    );
  }

  Future<String> createPost(CreatePostInput input) async {
    return await this._graphQL.mutate(
      options: MutationOptions(
        documentNode: gql('''
          mutation CreatePost(\$content: String!) {
            createPost(input: { content: \$content })
          }
        '''),
        variables: input.toMap(),
      ),
      parse: (data) => data['createPost'],
    );
  }
}