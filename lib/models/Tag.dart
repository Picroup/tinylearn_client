
import 'dart:convert';

import 'package:tinylearn_client/models/CursorPosts.dart';
import 'package:tinylearn_client/models/TagSum.dart';

import 'User.dart';

class Tag {
    final String name;
    final String kind;
    final TagSum sum;
    final User user;
    final CursorPosts posts;

    Tag({
        this.name,
        this.kind,
        this.sum,
        this.user,
        this.posts,
    });
    
    Tag copyWith({
        String name,
        String kind,
        TagSum sum,
        User user,
        CursorPosts posts,
    }) => 
        Tag(
            name: name ?? this.name,
            kind: kind ?? this.kind,
            sum: sum ?? this.sum,
            user: user ?? this.user,
            posts: posts ?? this.posts,
        );

    factory Tag.fromJson(String str) => Tag.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        name: json["name"] == null ? null : json["name"],
        kind: json["kind"] == null ? null : json["kind"],
        sum: json["sum"] == null ? null : TagSum.fromMap(json["sum"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        posts: json["posts"] == null ? null : CursorPosts.fromMap(json["posts"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "kind": kind == null ? null : kind,
        "sum": sum == null ? null : sum.toMap(),
        "user": user == null ? null : user.toMap(),
        "posts": posts == null ? null : posts.toMap(),
    };
}