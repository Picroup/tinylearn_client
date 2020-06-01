
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/functional/graphql/GraphQL.dart';
import 'package:tinylearn_client/functional/graphql_fragments/tagFragment.dart';
import 'package:tinylearn_client/functional/networking/TagService/types/TagsInput.dart';
import 'package:tinylearn_client/models/TagsData.dart';

class TagService {

  final GraphQL _graphQL;

  TagService(this._graphQL);

  Future<TagsData> tags(TagsInput input) async {
    return await _graphQL.query(
      options: QueryOptions(
        documentNode: gql('''
          query Tags(\$take: Int!, \$cursor: String) {
            tags(input: { take: \$take, cursor: \$cursor }) {
              $cursorTagsFragment
            }
          }
        '''),
        variables: input.toMap(),
      ),
      parse: (data) => TagsData.fromMap(data),
     );
  }
}