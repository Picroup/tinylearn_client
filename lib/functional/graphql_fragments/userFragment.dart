
final userBasicFragment = '''
  id
  username
  created
''';

final sessionInfoFragment = '''
  token
  user {
    $userBasicFragment
  }
''';