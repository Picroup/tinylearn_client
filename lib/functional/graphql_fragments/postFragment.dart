
import 'userFragment.dart';

final postBasicFragment = '''
  id
  created
  content
  user {
    $userBasicFragment
  }
''';

final cursorPostsFragment = '''
  cursor
  items {
    $postBasicFragment
  }
''';