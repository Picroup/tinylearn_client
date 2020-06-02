
final userBasicFragment = '''
  id
  username
  created
  imageURL
''';

final sessionInfoFragment = '''
  token
  user {
    $userBasicFragment
  }
''';