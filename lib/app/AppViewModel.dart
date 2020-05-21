


import 'package:flutter/foundation.dart';
import 'package:tinylearn_client/models/SessionInfo.dart';

class AppViewModel extends ChangeNotifier {

  // dependency
  final Future<SessionInfo> Function() getSessionInfo;
  final Future<bool> Function(SessionInfo) setSessionInfo;

  AppViewModel({this.getSessionInfo, this.setSessionInfo});

  // states
  SessionInfo sessionInfo;
  bool isSessionInfoInit = false;
  
  bool get isLogin => sessionInfo != null;

  void initSessionInfo() async {
    this.sessionInfo = await this.getSessionInfo();
    this.isSessionInfoInit = true;
    notifyListeners();
  }

  void onGetSessionInfo(SessionInfo sessionInfo) async {
    this.sessionInfo = sessionInfo;
    notifyListeners();
    await setSessionInfo(sessionInfo);
  }

  void onClearSessionInfo() async {
    this.sessionInfo = null;
    notifyListeners();
    await setSessionInfo(null);
  }

}