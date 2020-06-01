// To parse this JSON data, do
//
//     final cursorTags = cursorTagsFromJson(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/Tag.dart';

class CursorTags {
    final String cursor;
    final List<Tag> items;

    CursorTags({
        this.cursor,
        this.items,
    });

    factory CursorTags.fromJson(String str) => CursorTags.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CursorTags.fromMap(Map<String, dynamic> json) => CursorTags(
        cursor: json["cursor"] == null ? null : json["cursor"],
        items: json["items"] == null ? null : List<Tag>.from(json["items"].map((x) => Tag.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cursor": cursor == null ? null : cursor,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toMap())),
    };
}