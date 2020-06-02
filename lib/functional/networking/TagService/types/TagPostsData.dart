// To parse this JSON data, do
//
//     final tagPostsData = tagPostsDataFromJson(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/Tag.dart';

class TagPostsData {
    final Tag tag;

    TagPostsData({
        this.tag,
    });

    factory TagPostsData.fromJson(String str) => TagPostsData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TagPostsData.fromMap(Map<String, dynamic> json) => TagPostsData(
        tag: json["tag"] == null ? null : Tag.fromMap(json["tag"]),
    );

    Map<String, dynamic> toMap() => {
        "tag": tag == null ? null : tag.toMap(),
    };
}