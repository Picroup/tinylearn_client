import 'dart:convert';

import 'User.dart';

class Post {
    final String id;
    final int created;
    final String content;
    final String userId;
    final User user;

    Post({
        this.id,
        this.created,
        this.content,
        this.userId,
        this.user,
    });

    factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : json["created"],
        content: json["content"] == null ? null : json["content"],
        userId: json["userId"] == null ? null : json["userId"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created,
        "content": content == null ? null : content,
        "userId": userId == null ? null : userId,
        "user": user == null ? null : user.toMap(),
    };
}