


import 'package:flutter/foundation.dart';
import 'package:tinylearn_client/models/SessionInfo.dart';

class AppNotifier extends ChangeNotifier {

  // dependency
  final Future<SessionInfo> Function() getSessionInfo;
  final Future<bool> Function(SessionInfo) setSessionInfo;

  AppNotifier({this.getSessionInfo, this.setSessionInfo}) {
    initSessionInfo();
  }

  // states
  SessionInfo sessionInfo;
  bool isSessionInfoInit = false;
  
  bool get isLogin => sessionInfo != null;

  void initSessionInfo() async {
    this.sessionInfo = await this.getSessionInfo();
    this.isSessionInfoInit = true;
    notifyListeners();
  }

  void onUpdateSessionInfo(SessionInfo sessionInfo) async {
    this.sessionInfo = sessionInfo;
    notifyListeners();
    try {
      await setSessionInfo(sessionInfo);
    } catch (error) {
      print('$error');
    }
  }

  void onClearSessionInfo() async {
    this.sessionInfo = null;
    notifyListeners();
    try {
       await setSessionInfo(null);
    } catch (error) {
      print('$error');
    }
  }

}