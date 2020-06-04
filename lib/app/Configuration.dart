
final configuration = _dev;

final _dev = Configuration(
  uri: 'https://tinylearndev.picroup.com:444/',
  codeCountDownSeconds: 60,
);

final _local = Configuration(
  uri: 'http://10.0.0.105:4004/',
  codeCountDownSeconds: 60,
);

class Configuration {
  final String uri;
  final int codeCountDownSeconds;

  Configuration({this.codeCountDownSeconds, this.uri});
}