

import 'package:flutter/foundation.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:tinylearn_client/functional/foundation/SilenceChangeNotifier.dart';
import 'package:tinylearn_client/functional/graphql/errorMessage.dart';
import 'package:tinylearn_client/functional/networking/UserService/UserService.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/GetVerifyCodeInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/LoginOrRegisterInput.dart';

class LoginNotifier extends SilenceChangeNotifier {

  final AppNotifier appNotifier;
  final UserService userService;
  final int codeCountDownSeconds;
  
  LoginNotifier({
    @required this.appNotifier,
    @required this.userService,
    this.codeCountDownSeconds = 60,
  }): 
    assert(appNotifier != null),
    assert(userService != null);

  // states
  String phone = '';
  String code = '';
  bool isLoading = false;

  bool isGettingCode = false;
  int remainSeconds = 0;

  String message;

  // trigger
  int getCodeSuccessVersion;
  int loginSuccessVersion;

  bool get isLoginEnable => phone.length >= 11
      && code.length >= 6
      && !isLoading
      && !appNotifier.isLogin;

  bool get isCountingDown => remainSeconds > 0;

  bool get isGetCodeEnable => phone.length >= 11
    && !isCountingDown
    && !isGettingCode;

  String get getCodeText => remainSeconds == 0
    ? '获取验证码'
    : '重新获取($remainSeconds)';

  void onTriggerGetCode() async {
    if (!isGetCodeEnable) return;

    isGettingCode = true;
    notifyListeners();

    try {
      final code = await userService.getVerifyCode(GetVerifyCodeInput(phone: phone));
      isGettingCode = false;
      getCodeSuccessVersion = getCodeSuccessVersion == null ? 0 : getCodeSuccessVersion + 1;
      message = '获取验证码成功：$code';
      print(message);
      notifyListeners();

      remainSeconds = codeCountDownSeconds;
      notifyListeners();

      final counts = Stream.periodic(Duration(seconds: 1), (index) => index + 1).take(codeCountDownSeconds);
      await for (var passed in counts) {
        remainSeconds = codeCountDownSeconds - passed;
        notifyListeners();
      }

    } catch (error) {
      isGettingCode = false;
      message = errorMessage(error);
      print(message);
      notifyListeners();
    }
  }

  void onTiggerLogin() async {
    if (!isLoginEnable) return;

    isLoading = true;
    notifyListeners();

    try {
      final data = await userService.loginOrRegister(LoginOrRegisterInput(
        phone: phone, 
        code: code
      ));
      final sessionInfo = data.loginOrRegister;
      isLoading = false;
      loginSuccessVersion = loginSuccessVersion == null ? 0 : loginSuccessVersion + 1;
      message = '登录成功';
      print(message);
      notifyListeners();
      appNotifier.onUpdateSessionInfo(sessionInfo);
    } catch (error) {
      isLoading = false;
      message = errorMessage(error);
      print(message);
      notifyListeners();
    }
    
  }
  
  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }
  
  void setCode(String value) {
    code = value;
    notifyListeners();
  }
}
