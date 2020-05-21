


import 'package:tinylearn_client/functional/networking/UserService/types/LoginOrRegisterInput.dart';
import 'package:tinylearn_client/models/LoginOrRegisterData.dart';

abstract class UserService {

  Future<LoginOrRegisterData> loginOrRegister(LoginOrRegisterInput input);
}