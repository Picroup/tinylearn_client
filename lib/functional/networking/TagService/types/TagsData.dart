// To parse this JSON data, do
//
//     final tagsData = tagsDataFromJson(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/CursorTags.dart';


class TagsData {
    final CursorTags tags;

    TagsData({
        this.tags,
    });

    factory TagsData.fromJson(String str) => TagsData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TagsData.fromMap(Map<String, dynamic> json) => TagsData(
        tags: json["tags"] == null ? null : CursorTags.fromMap(json["tags"]),
    );

    Map<String, dynamic> toMap() => {
        "tags": tags == null ? null : tags.toMap(),
    };
}