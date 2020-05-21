
import 'dart:convert';

class User {
    final String id;
    final String username;
    final int created;

    User({
        this.id,
        this.username,
        this.created,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        created: json["created"] == null ? null : json["created"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "created": created == null ? null : created,
    };
}