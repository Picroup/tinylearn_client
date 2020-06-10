


import 'package:tinylearn_client/functional/networking/PostService/types/CursorInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/LoginOrRegisterInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/NotificationsData.dart';

import 'types/GetVerifyCodeInput.dart';
import 'types/LoginOrRegisterData.dart';

abstract class UserService {

  Future<LoginOrRegisterData> loginOrRegister(LoginOrRegisterInput input);
  Future<String> getVerifyCode(GetVerifyCodeInput input);
  Future<NotificationsData> notifications(CursorInput input);
  Future<String> markAllNotificationsAsRead();
}