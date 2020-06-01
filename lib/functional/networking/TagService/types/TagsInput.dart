// To parse this JSON data, do
//
//     final tagsInput = tagsInputFromJson(jsonString);

import 'dart:convert';

class TagsInput {
    final int take;
    final String cursor;

    TagsInput({
        this.take,
        this.cursor,
    });

    factory TagsInput.fromJson(String str) => TagsInput.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TagsInput.fromMap(Map<String, dynamic> json) => TagsInput(
        take: json["take"] == null ? null : json["take"],
        cursor: json["cursor"] == null ? null : json["cursor"],
    );

    Map<String, dynamic> toMap() => {
        "take": take == null ? null : take,
        "cursor": cursor == null ? null : cursor,
    };
}
