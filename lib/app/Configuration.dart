
final configuration = _dev;

final _dev = Configuration(
  uri: 'http://10.0.0.105:4004/',
  codeCountDownSeconds: 5,
);

class Configuration {
  final String uri;
  final int codeCountDownSeconds;

  Configuration({this.codeCountDownSeconds, this.uri});
}