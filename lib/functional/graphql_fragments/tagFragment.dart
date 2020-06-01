
import 'package:tinylearn_client/functional/graphql_fragments/userFragment.dart';

final tagBasicFragment = '''
  name
  kind
  user {
    $userBasicFragment
  }
''';

final cursorTagsFragment = '''
  cursor
  items {
    $tagBasicFragment
  }
''';