// To parse this JSON data, do
//
//     final cursorPosts = cursorPostsFromJson(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/Post.dart';

class CursorPosts {
    final String cursor;
    final List<Post> items;

    CursorPosts({
        this.cursor,
        this.items,
    });

    factory CursorPosts.fromJson(String str) => CursorPosts.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CursorPosts.fromMap(Map<String, dynamic> json) => CursorPosts(
        cursor: json["cursor"] == null ? null : json["cursor"],
        items: json["items"] == null ? null : List<Post>.from(json["items"].map((x) => Post.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cursor": cursor == null ? null : cursor,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toMap())),
    };
}