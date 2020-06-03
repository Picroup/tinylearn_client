// To parse this JSON data, do
//
//     final cursorInput = cursorInputFromMap(jsonString);

import 'dart:convert';

class CursorInput {
    CursorInput({
        this.take,
        this.cursor,
    });

    final int take;
    final String cursor;

    factory CursorInput.fromJson(String str) => CursorInput.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CursorInput.fromMap(Map<String, dynamic> json) => CursorInput(
        take: json["take"] == null ? null : json["take"],
        cursor: json["cursor"] == null ? null : json["cursor"],
    );

    Map<String, dynamic> toMap() => {
        "take": take == null ? null : take,
        "cursor": cursor == null ? null : cursor,
    };
}
