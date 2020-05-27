import 'package:flutter/foundation.dart';

class SilenceChangeNotifier extends ChangeNotifier {

  bool _isDisposed = false;

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    if (!_isDisposed) {
      _isDisposed = true;
    }
    super.dispose();
  }
}