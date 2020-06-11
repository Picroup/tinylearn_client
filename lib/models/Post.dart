// To parse this JSON data, do
//
//     final post = postFromMap(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/PostSum.dart';

import 'User.dart';
/**
{
  "id": "08e10ca9-e7cf-43c0-95a3-abc67b8bdaac",
  "created": 1590993590831,
  "content": "Java 从小白到大牛，JVM 不得不知的一些参数和配置\n 有的同学虽然写了一段时间 Java 了，但是对于 JVM 却不太关注。有的同学说，参数都是团队规定好的，部署的时候也不用我动手，关注它有什么用，而且，JVM 这东西，听上去就感觉很神秘很高深的样子，还是算了吧。 没错，部署的时候可能用不到你亲自动手，但是出现问题了怎么办，难道不用你解决问题吗，如果...\n https://juejin.im/post/5ecc6c216fb9a047d1126843",
  "userId": "f0d7f378-c508-4536-a0a1-9795a75537df",
  "sum": {
    "id": "08e10ca9-e7cf-43c0-95a3-abc67b8bdaac",
  },
  "user": {
    "id": "f0d7f378-c508-4536-a0a1-9795a75537df"
  }
}
 */

class Post {
    Post({
        this.id,
        this.created,
        this.content,
        this.userId,
        this.sum,
        this.user,
    });

    final String id;
    final int created;
    final String content;
    final String userId;
    final PostSum sum;
    final User user;

    factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : json["created"],
        content: json["content"] == null ? null : json["content"],
        userId: json["userId"] == null ? null : json["userId"],
        sum: json["sum"] == null ? null : PostSum.fromMap(json["sum"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created,
        "content": content == null ? null : content,
        "userId": userId == null ? null : userId,
        "sum": sum == null ? null : sum.toMap(),
        "user": user == null ? null : user.toMap(),
    };
}