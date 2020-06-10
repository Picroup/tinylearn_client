
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/functional/graphql/GraphQL.dart';
import 'package:tinylearn_client/functional/graphql_fragments/postFragment.dart';
import 'package:tinylearn_client/functional/graphql_fragments/tagFragment.dart';
import 'package:tinylearn_client/functional/graphql_fragments/userFragment.dart';
import 'package:tinylearn_client/functional/networking/TagService/types/TagPostsData.dart';
import 'package:tinylearn_client/functional/networking/TagService/types/TagPostsInput.dart';
import 'package:tinylearn_client/functional/networking/TagService/types/TagsInput.dart';

import 'types/TagsData.dart';

class TagService {

  final GraphQL _graphQL;

  TagService(this._graphQL);

  Future<TagsData> tags(TagsInput input) async {
    return await _graphQL.query(
      options: QueryOptions(
        documentNode: gql('''
          query Tags(\$take: Int!, \$cursor: String) {
            tags(input: { take: \$take, cursor: \$cursor }) {
              cursor
              items {
                $tagBasicFragment
                user {
                  $userBasicFragment
                }
              }
            }
          }
        '''),
        variables: input.toMap(),
      ),
      parse: (data) => TagsData.fromMap(data),
     );
  }

  Future<TagPostsData> tagPots(TagPostsInput input) async {
    return await _graphQL.query(
      options: QueryOptions(
        documentNode: gql('''
          query TagPosts(\$tagName: String!, \$take: Int!, \$cursor: String) {
            tag(input: { tagName:  \$tagName}) {
              $tagBasicFragment
              user {
                $userBasicFragment
              } 
              posts(input: { take: \$take, cursor: \$cursor}) {
                cursor
                items {
                  $postBasicFragment
                  user {
                    $userBasicFragment
                  }
                }
              }
            }
          }
        '''),
        variables: input.toMap(),
      ),
      parse: (data) => TagPostsData.fromMap(data),
    );
  }

}