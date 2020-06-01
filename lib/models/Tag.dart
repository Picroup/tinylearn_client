
import 'dart:convert';

import 'User.dart';

class Tag {
    final String name;
    final String kind;
    final User user;

    Tag({
        this.name,
        this.kind,
        this.user,
    });

    factory Tag.fromJson(String str) => Tag.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        name: json["name"] == null ? null : json["name"],
        kind: json["kind"] == null ? null : json["kind"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "kind": kind == null ? null : kind,
        "user": user == null ? null : user.toMap(),
    };
}