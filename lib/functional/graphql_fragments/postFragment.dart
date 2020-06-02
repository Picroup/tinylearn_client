
final postBasicFragment = '''
  id
  created
  content
''';

final cursorPostsFragment = '''
  cursor
  items {
    $postBasicFragment
  }
''';