// To parse this JSON data, do
//
//     final tagPostsInput = tagPostsInputFromJson(jsonString);

import 'dart:convert';

class TagPostsInput {
    final String tagName;
    final int take;
    final String cursor;

    TagPostsInput({
        this.tagName,
        this.take,
        this.cursor,
    });

    factory TagPostsInput.fromJson(String str) => TagPostsInput.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TagPostsInput.fromMap(Map<String, dynamic> json) => TagPostsInput(
        tagName: json["tagName"] == null ? null : json["tagName"],
        take: json["take"] == null ? null : json["take"],
        cursor: json["cursor"] == null ? null : json["cursor"],
    );

    Map<String, dynamic> toMap() => {
        "tagName": tagName == null ? null : tagName,
        "take": take == null ? null : take,
        "cursor": cursor == null ? null : cursor,
    };
}
