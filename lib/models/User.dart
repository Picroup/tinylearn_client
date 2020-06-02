// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
    final String id;
    final String username;
    final String imageUrl;

    User({
        this.id,
        this.username,
        this.imageUrl,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        imageUrl: json["imageURL"] == null ? null : json["imageURL"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "imageURL": imageUrl == null ? null : imageUrl,
    };
}
