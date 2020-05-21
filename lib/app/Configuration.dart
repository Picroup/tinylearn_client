
final configuration = _dev;

final _dev = Configuration(
  uri: 'http://10.0.0.105:4004/'
);

class Configuration {
  final String uri;

  Configuration({this.uri});
}