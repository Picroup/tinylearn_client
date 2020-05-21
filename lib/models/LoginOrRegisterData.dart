
import 'dart:convert';

import 'SessionInfo.dart';

class LoginOrRegisterData {
    final SessionInfo loginOrRegister;

    LoginOrRegisterData({
        this.loginOrRegister,
    });

    factory LoginOrRegisterData.fromJson(String str) => LoginOrRegisterData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginOrRegisterData.fromMap(Map<String, dynamic> json) => LoginOrRegisterData(
        loginOrRegister: json["loginOrRegister"] == null ? null : SessionInfo.fromMap(json["loginOrRegister"]),
    );

    Map<String, dynamic> toMap() => {
        "loginOrRegister": loginOrRegister == null ? null : loginOrRegister.toMap(),
    };
}
