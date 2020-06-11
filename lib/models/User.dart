// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'UserSum.dart';

class User {
    User({
        this.id,
        this.username,
        this.created,
        this.hasSetUsername,
        this.imageUrl,
        this.sum,
    });

    final String id;
    final String username;
    final int created;
    final bool hasSetUsername;
    final String imageUrl;
    final UserSum sum;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        created: json["created"] == null ? null : json["created"],
        hasSetUsername: json["hasSetUsername"] == null ? null : json["hasSetUsername"],
        imageUrl: json["imageURL"] == null ? null : json["imageURL"],
        sum: json["sum"] == null ? null : UserSum.fromMap(json["sum"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "created": created == null ? null : created,
        "hasSetUsername": hasSetUsername == null ? null : hasSetUsername,
        "imageURL": imageUrl == null ? null : imageUrl,
        "sum": sum == null ? null : sum.toMap(),
    };
}