
import 'dart:convert';

import 'User.dart';

class SessionInfo {
    final String token;
    final User user;

    SessionInfo({
        this.token,
        this.user,
    });

    factory SessionInfo.fromJson(String str) => SessionInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SessionInfo.fromMap(Map<String, dynamic> json) => SessionInfo(
        token: json["token"] == null ? null : json["token"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "token": token == null ? null : token,
        "user": user == null ? null : user.toMap(),
    };
}
